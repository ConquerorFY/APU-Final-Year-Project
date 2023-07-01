import 'package:flutter/material.dart';
import 'package:etaman_frontend/screens/home.dart';
import 'package:etaman_frontend/screens/loading.dart';
import 'package:etaman_frontend/screens/choose_location.dart';

void main() => runApp(MaterialApp(initialRoute: '/', routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation(),
    }));
