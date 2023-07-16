import 'package:etaman_frontend/screens/createpost.dart';
import 'package:etaman_frontend/screens/joingroup.dart';
import 'package:etaman_frontend/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:etaman_frontend/screens/register.dart';
import 'package:etaman_frontend/screens/login.dart';
import 'package:etaman_frontend/screens/home.dart';
import 'package:etaman_frontend/screens/profile.dart';
import 'package:etaman_frontend/screens/editprofile.dart';

void main() => runApp(MaterialApp(initialRoute: '/', routes: {
      '/': (context) => const Login(),
      '/register': (context) => const Register(),
      '/home': (context) => const Home(),
      '/profile': (context) => const Profile(),
      '/editProfile': (context) => const EditProfile(),
      '/createPost': (context) => const CreatePost(),
      '/map': (context) => const MapView(),
      '/joingroup': (context) => const JoinGroup(),
    }));
