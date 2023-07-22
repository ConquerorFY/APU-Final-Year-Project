import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:etaman_frontend/services/validator.dart';
import 'package:flutter/material.dart';
import 'package:etaman_frontend/services/api.dart';

class RegisterFacilities extends StatefulWidget {
  const RegisterFacilities({super.key});

  @override
  RegisterFacilitiesState createState() => RegisterFacilitiesState();
}

class RegisterFacilitiesState extends State<RegisterFacilities> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState<String>> _nameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _descriptionKey =
      GlobalKey<FormFieldState<String>>();

  AuthService authService = AuthService();
  Validator validator = Validator(); // Text Form Field Validator
  ApiService apiService = ApiService(); // API Service
  PopupService popupService = PopupService(); // Popup Service
  Settings settings = Settings(); // Settings Service

  void resetData() {
    setState(() {
      _nameKey.currentState?.reset();
      _descriptionKey.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: settings.registerFacilitiesBgColor,
          title: Text('Register Facilities',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  fontFamily: "OpenSans",
                  color: settings.registerFacilitiesTextFieldText2Color)),
          shadowColor: settings.registerFacilitiesTextFieldShadowColor,
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
                      validator: (value) {
                        return validator.validateName(value);
                      },
                      onChanged: (value) {
                        _nameKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.registerFacilitiesTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor:
                          settings.registerFacilitiesTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color:
                                settings.registerFacilitiesTextFieldTextColor),
                        labelText: 'Name',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings
                                    .registerFacilitiesTextFieldBorderColor,
                                width: settings
                                    .registerFacilitiesTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings
                                    .registerFacilitiesTextFieldBorderColor,
                                width: settings
                                        .registerFacilitiesTextFieldBorderWidth +
                                    1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _descriptionKey,
                      validator: (value) {
                        return validator.validateDescription(value);
                      },
                      onChanged: (value) {
                        _descriptionKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.registerFacilitiesTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor:
                          settings.registerFacilitiesTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color:
                                settings.registerFacilitiesTextFieldTextColor),
                        labelText: 'Description',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings
                                    .registerFacilitiesTextFieldBorderColor,
                                width: settings
                                    .registerFacilitiesTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings
                                    .registerFacilitiesTextFieldBorderColor,
                                width: settings
                                        .registerFacilitiesTextFieldBorderWidth +
                                    1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ]),
                ),
                ElevatedButton(
                    onPressed: () async {
                      // Handle registration process
                      Map<String, dynamic> facilitiesData = {
                        "name": _nameKey.currentState?.value,
                        "description": _descriptionKey.currentState?.value,
                        "token": authService.getAuthToken()
                      };
                      if (!(_nameKey.currentState!.validate() &&
                          _descriptionKey.currentState!.validate())) {
                        popupService.showErrorPopup(
                            context,
                            "Validation Message",
                            "Please ensure all fields are valid before submitting!",
                            () {});
                      } else {
                        final response = await apiService
                            .registerGroupFacilities(facilitiesData);
                        if (response != null) {
                          final status = response["status"];
                          final message = response["data"]["message"];
                          if (status > 0) {
                            // Success message
                            // ignore: use_build_context_synchronously
                            popupService.showSuccessPopup(
                                context, "Registration Success", message, () {
                              resetData();
                            });
                          } else {
                            // Error message
                            // ignore: use_build_context_synchronously
                            popupService.showErrorPopup(
                                context, "Registration Error", message, () {});
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            settings.registerFacilitiesTextFieldTextColor),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.fromLTRB(50, 20, 50, 20))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.app_registration,
                              color: settings
                                  .registerFacilitiesTextFieldIconColor),
                          const SizedBox(width: 8),
                          Text('Submit',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "OpenSans",
                                  color: settings
                                      .registerFacilitiesTextFieldText2Color)),
                        ])),
              ],
            ),
          ),
        ));
  }
}
