import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';
import 'package:etaman_frontend/services/api.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState<String>> _usernameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();

  ApiService apiService = ApiService(); // API Service
  PopupService popupService = PopupService(); // Popup Service
  AuthService authService = AuthService(); // Auth Service
  Settings settings = Settings(); // Settings Service

  String usernameVal = '';
  String passwordVal = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      ColorFiltered(
        colorFilter: ColorFilter.mode(
          settings.loginTextFieldBgColor,
          BlendMode.srcATop,
        ),
        child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/neighborhood.png'),
                    fit: BoxFit.cover))),
      ),
      Container(
        color: const Color.fromRGBO(0, 0, 0,
            0.6), // Replace '0.5' with the desired opacity value (0.0 to 1.0)
      ),
      SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Stack(alignment: Alignment.center, children: [
                SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.contain,
                            width: 250,
                            height: 250,
                            // Add any other custom image settings you need
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text('eTaman',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w800,
                                fontFamily: "OpenSans",
                                color: settings.loginTextFieldTextColor)),
                        const SizedBox(height: 10),
                        FractionallySizedBox(
                            widthFactor: 1.0,
                            child: Center(
                                child: Text(
                                    '~ Connect, Share, and Unite in Your Neighborhood! ~',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "OpenSans",
                                        color: settings
                                            .loginTextFieldTextColor)))),
                        const SizedBox(height: 50),
                        Form(
                            key: _formKey,
                            child: FractionallySizedBox(
                                widthFactor: 0.8,
                                child: Column(children: [
                                  TextFormField(
                                    key: _usernameKey,
                                    style: TextStyle(
                                        color: settings.loginTextFieldTextColor,
                                        fontSize: 16,
                                        fontFamily: 'OpenSans'),
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                        focusColor: Colors.white,
                                        labelStyle: TextStyle(
                                            color: settings
                                                .loginTextFieldTextColor),
                                        labelText: 'Username',
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: settings
                                                    .loginTextFieldBorderColor,
                                                width: settings
                                                    .loginTextFieldBorderWidth)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: settings
                                                    .loginTextFieldBorderColor,
                                                width: settings
                                                        .loginTextFieldBorderWidth +
                                                    1.0))),
                                    onChanged: (value) {
                                      setState(() {
                                        usernameVal = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    key: _passwordKey,
                                    obscureText: true,
                                    style: TextStyle(
                                        color: settings.loginTextFieldTextColor,
                                        fontSize: 16,
                                        fontFamily: 'OpenSans'),
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                            color: settings
                                                .loginTextFieldTextColor),
                                        labelText: 'Password',
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: settings
                                                    .loginTextFieldBorderColor,
                                                width: settings
                                                    .loginTextFieldBorderWidth)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: settings
                                                    .loginTextFieldBorderColor,
                                                width: settings
                                                        .loginTextFieldBorderWidth +
                                                    1.0))),
                                    onChanged: (value) {
                                      setState(() {
                                        passwordVal = value;
                                      });
                                    },
                                  )
                                ]))),
                        const SizedBox(height: 40),
                        ElevatedButton(
                            onPressed: () async {
                              // Handle Login Process
                              Map<String, dynamic> loginData = {
                                "username": usernameVal,
                                "password": passwordVal,
                              };
                              final response =
                                  await apiService.loginAccount(loginData);
                              if (response != null) {
                                final status = response["status"];
                                final message = response["data"]["message"];
                                if (status > 0) {
                                  // Set auth token
                                  final authToken = response["data"]["token"];
                                  authService.setAuthToken(authToken);
                                  // Success message
                                  // ignore: use_build_context_synchronously
                                  popupService.showSuccessPopup(
                                      context, "Login Success", message, () {
                                    // Navigate to home screen
                                    Navigator.pushNamed(context, '/home');
                                  });
                                } else {
                                  // Error message
                                  // ignore: use_build_context_synchronously
                                  popupService.showErrorPopup(
                                      context, "Login Error", message, () {});
                                }
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        settings.loginTextFieldButtonColor),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(20))),
                            child: FractionallySizedBox(
                                widthFactor: 0.77,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.login,
                                          color:
                                              settings.loginTextFieldIconColor),
                                      const SizedBox(width: 8.0),
                                      Text('Login As User',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "OpenSans",
                                              color: settings
                                                  .loginTextFieldTextColor)),
                                    ]))),
                        const SizedBox(height: 80),
                      ],
                    )),
                Positioned(
                    bottom: 30,
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to Register Screen
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text('Register Here',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline,
                              fontFamily: "OpenSans",
                              color: settings.loginTextFieldText2Color)),
                    )),
              ])))
    ]));
  }
}
