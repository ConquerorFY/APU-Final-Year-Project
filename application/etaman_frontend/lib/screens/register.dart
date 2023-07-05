import 'package:etaman_frontend/services/popup.dart';
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

  String nameVal = '';
  String emailVal = '';
  String stateVal = '';
  String cityVal = '';
  String postcodeVal = '';
  String streetVal = '';
  String contactVal = '';
  String usernameVal = '';
  String passwordVal = '';

  Validator validator = Validator(); // Text Form Field Validator
  ApiService apiService = ApiService(); // API Service
  PopupService popupService = PopupService(); // Popup Service

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Register Account',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  fontFamily: "OpenSans",
                  color: Colors.white)),
          shadowColor: Colors.green.shade900,
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
                        if (_nameKey.currentState!.validate()) {
                          setState(() {
                            nameVal = value;
                          });
                        }
                      },
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: Colors.green,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.green),
                        labelText: 'Name',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _emailKey,
                      validator: (value) {
                        return validator.validateEmail(value);
                      },
                      onChanged: (value) {
                        if (_emailKey.currentState!.validate()) {
                          setState(() {
                            emailVal = value;
                          });
                        }
                      },
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: Colors.green,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.green),
                        labelText: 'Email',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _stateKey,
                      validator: (value) {
                        return validator.validateState(value);
                      },
                      onChanged: (value) {
                        if (_stateKey.currentState!.validate()) {
                          setState(() {
                            stateVal = value;
                          });
                        }
                      },
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: Colors.green,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.green),
                        labelText: 'State',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _cityKey,
                      validator: (value) {
                        return validator.validateCity(value);
                      },
                      onChanged: (value) {
                        if (_cityKey.currentState!.validate()) {
                          setState(() {
                            cityVal = value;
                          });
                        }
                      },
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: Colors.green,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.green),
                        labelText: 'City',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _postcodeKey,
                      validator: (value) {
                        return validator.validatePostcode(value);
                      },
                      onChanged: (value) {
                        if (_postcodeKey.currentState!.validate()) {
                          setState(() {
                            postcodeVal = value;
                          });
                        }
                      },
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: Colors.green,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.green),
                        labelText: 'Postcode',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _streetKey,
                      validator: (value) {
                        return validator.validateStreet(value);
                      },
                      onChanged: (value) {
                        if (_streetKey.currentState!.validate()) {
                          setState(() {
                            streetVal = value;
                          });
                        }
                      },
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: Colors.green,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.green),
                        labelText: 'Street',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _contactKey,
                      validator: (value) {
                        return validator.validateContact(value);
                      },
                      onChanged: (value) {
                        if (_contactKey.currentState!.validate()) {
                          setState(() {
                            contactVal = value;
                          });
                        }
                      },
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: Colors.green,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.green),
                        labelText: 'Contact Number',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _usernameKey,
                      validator: (value) {
                        return validator.validateUsername(value);
                      },
                      onChanged: (value) {
                        if (_usernameKey.currentState!.validate()) {
                          setState(() {
                            usernameVal = value;
                          });
                        }
                      },
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: Colors.green,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.green),
                        labelText: 'Username',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _passwordKey,
                      validator: (value) {
                        return validator.validatePassword(value);
                      },
                      onChanged: (value) {
                        if (_postcodeKey.currentState!.validate()) {
                          setState(() {
                            passwordVal = value;
                          });
                        }
                      },
                      obscureText: true,
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: Colors.green,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.green),
                        labelText: 'Password',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ]),
                ),
                ElevatedButton(
                    onPressed: () async {
                      // Handle registration process
                      Map<String, dynamic> userData = {
                        "name": nameVal,
                        "email": emailVal,
                        "contact": contactVal,
                        "state": stateVal,
                        "city": cityVal,
                        "street": streetVal,
                        "postcode": postcodeVal,
                        "username": usernameVal,
                        "password": passwordVal
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
                            "Please ensure all fields are valid before submitting!");
                      } else {
                        final response =
                            await apiService.registerAccount(userData);
                        if (response != null) {
                          final status = response["status"];
                          final message = response["data"]["message"];
                          if (status > 0) {
                            // Success message
                            // ignore: use_build_context_synchronously
                            popupService.showSuccessPopup(
                                context, "Registration Success", message);
                          } else {
                            // Error message
                            // ignore: use_build_context_synchronously
                            popupService.showErrorPopup(
                                context, "Registration Error", message);
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.fromLTRB(50, 20, 50, 20))),
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.app_registration, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Register',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "OpenSans",
                                  color: Colors.white)),
                        ])),
              ],
            ),
          ),
        ));
  }
}
