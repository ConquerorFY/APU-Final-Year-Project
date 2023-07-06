import 'package:flutter/material.dart';
import 'package:etaman_frontend/screens/register.dart';
import 'package:etaman_frontend/screens/login.dart';
import 'package:etaman_frontend/screens/home.dart';

void main() => runApp(MaterialApp(initialRoute: '/', routes: {
      '/': (context) => const Login(),
      '/register': (context) => const Register(),
      '/home': (context) => const Home(),
    }));
