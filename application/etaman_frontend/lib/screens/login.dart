import 'package:flutter/material.dart';

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

  String usernameVal = '';
  String passwordVal = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.green.withOpacity(0.6),
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
              child: SizedBox(
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
                      const Text('eTaman',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w800,
                              fontFamily: "OpenSans",
                              color: Colors.white)),
                      const SizedBox(height: 10),
                      const FractionallySizedBox(
                          widthFactor: 1.0,
                          child: Center(
                              child: Text(
                                  '~ Connect, Share, and Unite in Your Neighborhood! ~',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "OpenSans",
                                      color: Colors.white)))),
                      const SizedBox(height: 50),
                      Form(
                          key: _formKey,
                          child: FractionallySizedBox(
                              widthFactor: 0.8,
                              child: Column(children: [
                                TextFormField(
                                    key: _usernameKey,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'OpenSans'),
                                    cursorColor: Colors.white,
                                    decoration: const InputDecoration(
                                        focusColor: Colors.white,
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        labelText: 'Username',
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 2.0)))),
                                const SizedBox(height: 20),
                                TextFormField(
                                    key: _passwordKey,
                                    obscureText: true,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'OpenSans'),
                                    cursorColor: Colors.white,
                                    decoration: const InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        labelText: 'Password',
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 2.0))))
                              ]))),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          // Handle Login Process
                          Navigator.pushNamed(context, '/login');
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green.shade400),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(20))),
                        child: const Text('Login As User',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "OpenSans",
                                color: Colors.white)),
                      ),
                      const SizedBox(height: 80),
                      GestureDetector(
                        onTap: () {
                          // Navigate to Register Screen
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text('Register Here',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                                fontFamily: "OpenSans",
                                color: Colors.white)),
                      ),
                    ],
                  ))))
    ]));
  }
}
