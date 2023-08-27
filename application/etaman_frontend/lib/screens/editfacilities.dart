import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:etaman_frontend/services/validator.dart';
import 'package:flutter/material.dart';
import 'package:etaman_frontend/services/api.dart';

class EditFacilities extends StatefulWidget {
  const EditFacilities({super.key});

  @override
  EditFacilitiesState createState() => EditFacilitiesState();
}

class EditFacilitiesState extends State<EditFacilities> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState<String>> _nameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _descriptionKey =
      GlobalKey<FormFieldState<String>>();

  dynamic facilitiesID;
  dynamic facilitiesData;

  Validator validator = Validator();
  ApiService apiService = ApiService();
  PopupService popupService = PopupService();
  AuthService authService = AuthService();
  Settings settings = Settings();

  void getFacilitiesData() async {
    final facilitiesResponse = await apiService
        .getSpecificGroupFacilities({"facilitiesID": facilitiesID});
    if (facilitiesResponse != null) {
      final status = facilitiesResponse['status'];
      if (status > 0) {
        // Success
        setState(() {
          facilitiesData = facilitiesResponse['data']['list'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      setState(() {
        facilitiesID = arguments['facilitiesID'];
        facilitiesData = {
          "name": arguments['facilitiesName'],
          "description": arguments['facilitiesDescription']
        };
      });
      return Scaffold(
          appBar: AppBar(
            backgroundColor: settings.editProfileBgColor,
            title: Text('Edit Facilities',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    fontFamily: "OpenSans",
                    color: settings.editProfileTextFieldText2Color)),
            shadowColor: settings.editProfileTextFieldShadowColor,
            elevation: 5.0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      TextFormField(
                        key: _nameKey,
                        initialValue: facilitiesData['name'],
                        validator: (value) {
                          return validator.validateName(value);
                        },
                        onChanged: (value) {
                          _nameKey.currentState!.validate();
                        },
                        style: TextStyle(
                            color: settings.editProfileTextFieldTextColor,
                            fontSize: 16,
                            fontFamily: 'OpenSans'),
                        cursorColor: settings.editProfileTextFieldCursorColor,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: settings.editProfileTextFieldTextColor),
                          labelText: 'Name',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      settings.editProfileTextFieldBorderColor,
                                  width: settings
                                      .editProfileTextFieldBorderWidth)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      settings.editProfileTextFieldBorderColor,
                                  width:
                                      settings.editProfileTextFieldBorderWidth +
                                          1.0)),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        key: _descriptionKey,
                        initialValue: facilitiesData['description'],
                        validator: (value) {
                          return validator.validateDescription(value);
                        },
                        onChanged: (value) {
                          _descriptionKey.currentState!.validate();
                        },
                        style: TextStyle(
                            color: settings.editProfileTextFieldTextColor,
                            fontSize: 16,
                            fontFamily: 'OpenSans'),
                        cursorColor: settings.editProfileTextFieldCursorColor,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: settings.editProfileTextFieldTextColor),
                          labelText: 'Description',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      settings.editProfileTextFieldBorderColor,
                                  width: settings
                                      .editProfileTextFieldBorderWidth)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      settings.editProfileTextFieldBorderColor,
                                  width:
                                      settings.editProfileTextFieldBorderWidth +
                                          1.0)),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ]),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        // Handle edit facilities process
                        Map<String, dynamic> fData = {
                          "name": _nameKey.currentState?.value,
                          "description": _descriptionKey.currentState?.value,
                        };
                        if (!(_nameKey.currentState!.validate() &&
                            _descriptionKey.currentState!.validate())) {
                          popupService.showErrorPopup(
                              context,
                              "Validation Message",
                              "Please ensure all fields are valid before submitting!",
                              () {});
                        } else {
                          // Filter out attributes that are not changed / updated by user
                          fData.removeWhere(
                              (key, value) => facilitiesData[key] == value);
                          // Add token into facilitiesData
                          fData['token'] = authService.getAuthToken();
                          fData['facilitiesID'] = facilitiesID;
                          final response =
                              await apiService.editGroupFacilitiesAPI(fData);
                          if (response != null) {
                            final status = response["status"];
                            final message = response["data"]["message"];
                            if (status > 0) {
                              // Success message
                              // ignore: use_build_context_synchronously
                              popupService.showSuccessPopup(
                                  context, "Edit Facilities Success", message,
                                  () {
                                getFacilitiesData();
                              });
                            } else {
                              // Error message
                              // ignore: use_build_context_synchronously
                              popupService.showErrorPopup(context,
                                  "Edit Facilities Error", message, () {});
                            }
                          }
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              settings.editProfileTextFieldTextColor),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.fromLTRB(50, 20, 50, 20))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit,
                                color: settings.editProfileTextFieldIconColor),
                            const SizedBox(width: 8),
                            Text('Edit',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "OpenSans",
                                    color: settings
                                        .editProfileTextFieldText2Color)),
                          ])),
                ],
              ),
            ),
          ));
    } else {
      return const Scaffold();
    }
  }
}
