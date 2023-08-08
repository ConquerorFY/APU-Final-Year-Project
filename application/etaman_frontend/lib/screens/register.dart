import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:etaman_frontend/services/validator.dart';
import 'package:flutter/material.dart';
import 'package:etaman_frontend/services/api.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState<String>> _nameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _stateKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _cityKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _postcodeKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _streetKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _contactKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _usernameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();

  Validator validator = Validator(); // Text Form Field Validator
  ApiService apiService = ApiService(); // API Service
  PopupService popupService = PopupService(); // Popup Service
  Settings settings = Settings(); // Settings Service

  void resetData() {
    setState(() {
      _nameKey.currentState?.reset();
      _emailKey.currentState?.reset();
      _stateKey.currentState?.reset();
      _cityKey.currentState?.reset();
      _postcodeKey.currentState?.reset();
      _streetKey.currentState?.reset();
      _contactKey.currentState?.reset();
      _usernameKey.currentState?.reset();
      _passwordKey.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: settings.registerBgColor,
          title: Text('Register Account',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  fontFamily: "OpenSans",
                  color: settings.registerTextFieldText2Color)),
          shadowColor: settings.registerTextFieldShadowColor,
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
                          color: settings.registerTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.registerTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.registerTextFieldTextColor),
                        labelText: 'Name',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth +
                                    1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _emailKey,
                      validator: (value) {
                        return validator.validateEmail(value);
                      },
                      onChanged: (value) {
                        _emailKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.registerTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.registerTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.registerTextFieldTextColor),
                        labelText: 'Email',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth +
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
                          color: settings.registerTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.registerTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.registerTextFieldTextColor),
                        labelText: 'State',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth +
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
                          color: settings.registerTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.registerTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.registerTextFieldTextColor),
                        labelText: 'City',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth +
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
                          color: settings.registerTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.registerTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.registerTextFieldTextColor),
                        labelText: 'Postcode',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth +
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
                          color: settings.registerTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.registerTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.registerTextFieldTextColor),
                        labelText: 'Street',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth +
                                    1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _contactKey,
                      validator: (value) {
                        return validator.validateContact(value);
                      },
                      onChanged: (value) {
                        _contactKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.registerTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.registerTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.registerTextFieldTextColor),
                        labelText: 'Contact Number',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth +
                                    1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _usernameKey,
                      validator: (value) {
                        return validator.validateUsername(value);
                      },
                      onChanged: (value) {
                        _usernameKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.registerTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.registerTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.registerTextFieldTextColor),
                        labelText: 'Username',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth +
                                    1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _passwordKey,
                      validator: (value) {
                        return validator.validatePassword(value);
                      },
                      onChanged: (value) {
                        _passwordKey.currentState!.validate();
                      },
                      obscureText: true,
                      style: TextStyle(
                          color: settings.registerTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.registerTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.registerTextFieldTextColor),
                        labelText: 'Password',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.registerTextFieldBorderColor,
                                width: settings.registerTextFieldBorderWidth +
                                    1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ]),
                ),
                ElevatedButton(
                    onPressed: () async {
                      // Handle registration process
                      Map<String, dynamic> userData = {
                        "name": _nameKey.currentState?.value,
                        "email": _emailKey.currentState?.value,
                        "contact": _contactKey.currentState?.value,
                        "state": _stateKey.currentState?.value,
                        "city": _cityKey.currentState?.value,
                        "street": _streetKey.currentState?.value,
                        "postcode": _postcodeKey.currentState?.value,
                        "username": _usernameKey.currentState?.value,
                        "password": _passwordKey.currentState?.value
                      };
                      if (!(_nameKey.currentState!.validate() &&
                          _emailKey.currentState!.validate() &&
                          _stateKey.currentState!.validate() &&
                          _cityKey.currentState!.validate() &&
                          _postcodeKey.currentState!.validate() &&
                          _streetKey.currentState!.validate() &&
                          _contactKey.currentState!.validate() &&
                          _usernameKey.currentState!.validate() &&
                          _passwordKey.currentState!.validate())) {
                        popupService.showErrorPopup(
                            context,
                            "Validation Message",
                            "Please ensure all fields are valid before submitting!",
                            () {});
                      } else {
                        bool isValidatedAddress =
                            await validator.validateAddress(
                                _streetKey.currentState?.value,
                                _postcodeKey.currentState?.value,
                                _cityKey.currentState?.value,
                                _stateKey.currentState?.value);
                        if (!isValidatedAddress) {
                          // ignore: use_build_context_synchronously
                          popupService.showErrorPopup(
                              context,
                              "Validation Message",
                              "Please ensure the address details provided are valid (in Malaysia) before submitting!",
                              () {});
                          return;
                        }
                        final response =
                            await apiService.registerAccountAPI(userData);
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
                            settings.registerTextFieldTextColor),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.fromLTRB(50, 20, 50, 20))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.app_registration,
                              color: settings.registerTextFieldIconColor),
                          const SizedBox(width: 8),
                          Text('Register',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "OpenSans",
                                  color: settings.registerTextFieldText2Color)),
                        ])),
              ],
            ),
          ),
        ));
  }
}
