import 'package:etaman_frontend/services/validator.dart';
import 'package:flutter/material.dart';

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

  String _nameVal = '';
  String _emailVal = '';
  String _stateVal = '';
  String _cityVal = '';
  String _postcodeVal = '';
  String _streetVal = '';
  String _contactVal = '';
  String _usernameVal = '';
  String _passwordVal = '';

  Validator validator = Validator(); // text form field validator

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Register Page',
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
                            _nameVal = value;
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
                            _emailVal = value;
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
                            _stateVal = value;
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
                            _cityVal = value;
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
                            _postcodeVal = value;
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
                            _streetVal = value;
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
                            _contactVal = value;
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
                            _usernameVal = value;
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
                            _passwordVal = value;
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
                  onPressed: () {
                    // Handle registration process
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.fromLTRB(50, 20, 50, 20))),
                  child: const Text('Register',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          fontFamily: "OpenSans",
                          color: Colors.white)),
                ),
              ],
            ),
          ),
        ));
  }
}
