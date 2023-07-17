import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:etaman_frontend/services/validator.dart';
import 'package:flutter/material.dart';
import 'package:etaman_frontend/services/api.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  CreateGroupState createState() => CreateGroupState();
}

class CreateGroupState extends State<CreateGroup> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState<String>> _nameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _stateKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _cityKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _postcodeKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _streetKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _rulesKey =
      GlobalKey<FormFieldState<String>>();

  Validator validator = Validator();
  ApiService apiService = ApiService();
  PopupService popupService = PopupService();
  AuthService authService = AuthService();
  Settings settings = Settings();

  void resetData() {
    _nameKey.currentState?.reset();
    _stateKey.currentState?.reset();
    _cityKey.currentState?.reset();
    _postcodeKey.currentState?.reset();
    _streetKey.currentState?.reset();
    _rulesKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: settings.createGroupBgColor,
          title: Text('Create Neighborhood Group',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  fontFamily: "OpenSans",
                  color: settings.createGroupTextFieldText2Color)),
          shadowColor: settings.createGroupTextFieldShadowColor,
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
                          color: settings.createGroupTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.createGroupTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.createGroupTextFieldTextColor),
                        labelText: 'Group Name',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.createGroupTextFieldBorderColor,
                                width:
                                    settings.createGroupTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.createGroupTextFieldBorderColor,
                                width:
                                    settings.createGroupTextFieldBorderWidth +
                                        1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _stateKey,
                      validator: (value) {
                        return validator.validateState(value);
                      },
                      onChanged: (value) {
                        _stateKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.createGroupTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.createGroupTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.createGroupTextFieldTextColor),
                        labelText: 'State',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.createGroupTextFieldBorderColor,
                                width:
                                    settings.createGroupTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.createGroupTextFieldBorderColor,
                                width:
                                    settings.createGroupTextFieldBorderWidth +
                                        1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _cityKey,
                      validator: (value) {
                        return validator.validateCity(value);
                      },
                      onChanged: (value) {
                        _cityKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.createGroupTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.createGroupTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.createGroupTextFieldTextColor),
                        labelText: 'City',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.createGroupTextFieldBorderColor,
                                width:
                                    settings.createGroupTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.createGroupTextFieldBorderColor,
                                width:
                                    settings.createGroupTextFieldBorderWidth +
                                        1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _postcodeKey,
                      validator: (value) {
                        return validator.validatePostcode(value);
                      },
                      onChanged: (value) {
                        _postcodeKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.createGroupTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.createGroupTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.createGroupTextFieldTextColor),
                        labelText: 'Postcode',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.createGroupTextFieldBorderColor,
                                width:
                                    settings.createGroupTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.createGroupTextFieldBorderColor,
                                width:
                                    settings.createGroupTextFieldBorderWidth +
                                        1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _streetKey,
                      validator: (value) {
                        return validator.validateStreet(value);
                      },
                      onChanged: (value) {
                        _streetKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.createGroupTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.createGroupTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.createGroupTextFieldTextColor),
                        labelText: 'Street',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.createGroupTextFieldBorderColor,
                                width:
                                    settings.createGroupTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.createGroupTextFieldBorderColor,
                                width:
                                    settings.createGroupTextFieldBorderWidth +
                                        1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _rulesKey,
                      validator: (value) {
                        return validator.validateRules(value);
                      },
                      onChanged: (value) {
                        _rulesKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.createGroupTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.createGroupTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.createGroupTextFieldTextColor),
                        labelText: 'Group Rules',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.createGroupTextFieldBorderColor,
                                width:
                                    settings.createGroupTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.createGroupTextFieldBorderColor,
                                width:
                                    settings.createGroupTextFieldBorderWidth +
                                        1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ]),
                ),
                ElevatedButton(
                    onPressed: () async {
                      // Handle create neighborhood group process
                      Map<String, dynamic> groupData = {
                        "name": _nameKey.currentState?.value,
                        "state": _stateKey.currentState?.value,
                        "city": _cityKey.currentState?.value,
                        "street": _streetKey.currentState?.value,
                        "postcode": _postcodeKey.currentState?.value,
                        "rules": _rulesKey.currentState?.value,
                        "token": authService.getAuthToken()
                      };
                      if (!(_nameKey.currentState!.validate() &&
                          _stateKey.currentState!.validate() &&
                          _cityKey.currentState!.validate() &&
                          _postcodeKey.currentState!.validate() &&
                          _streetKey.currentState!.validate() &&
                          _rulesKey.currentState!.validate())) {
                        popupService.showErrorPopup(
                            context,
                            "Validation Message",
                            "Please ensure all fields are valid before submitting!",
                            () {});
                      } else {
                        final groupResponse = await apiService
                            .createNeighborhoodGroupAPI(groupData);
                        if (groupResponse != null) {
                          final status = groupResponse['status'];
                          if (status > 0) {
                            // Success
                            final message = groupResponse['data']['message'];
                            // ignore: use_build_context_synchronously
                            popupService.showSuccessPopup(
                                context, "Create Group Success", message, () {
                              resetData();
                            });
                          } else {
                            // Error
                            final message = groupResponse['data']['message'];
                            // ignore: use_build_context_synchronously
                            popupService.showErrorPopup(context,
                                "Create Group Success", message, () {});
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            settings.createGroupTextFieldTextColor),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.fromLTRB(50, 20, 50, 20))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.group_add,
                              color: settings.createGroupTextFieldIconColor),
                          const SizedBox(width: 8),
                          Text('Create',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "OpenSans",
                                  color:
                                      settings.createGroupTextFieldText2Color)),
                        ])),
              ],
            ),
          ),
        ));
  }
}
