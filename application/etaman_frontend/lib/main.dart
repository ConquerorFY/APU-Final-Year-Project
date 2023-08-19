import 'package:etaman_frontend/screens/chat.dart';
import 'package:etaman_frontend/screens/creategroup.dart';
import 'package:etaman_frontend/screens/createpost.dart';
import 'package:etaman_frontend/screens/editfacilities.dart';
import 'package:etaman_frontend/screens/editgroup.dart';
import 'package:etaman_frontend/screens/editpost.dart';
import 'package:etaman_frontend/screens/editpostcomment.dart';
import 'package:etaman_frontend/screens/emergency.dart';
import 'package:etaman_frontend/screens/facilities.dart';
import 'package:etaman_frontend/screens/findresidents.dart';
import 'package:etaman_frontend/screens/joingroup.dart';
import 'package:etaman_frontend/screens/managegroup.dart';
import 'package:etaman_frontend/screens/map.dart';
import 'package:etaman_frontend/screens/registerfacilities.dart';
import 'package:etaman_frontend/screens/settingsview.dart';
import 'package:etaman_frontend/screens/viewpost.dart';
import 'package:etaman_frontend/services/components.dart';
import 'package:etaman_frontend/services/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:etaman_frontend/screens/register.dart';
import 'package:etaman_frontend/screens/login.dart';
import 'package:etaman_frontend/screens/home.dart';
import 'package:etaman_frontend/screens/profile.dart';
import 'package:etaman_frontend/screens/editprofile.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/register': (context) => const Register(),
          '/home': (context) => const Home(),
          '/profile': (context) => const Profile(),
          '/editProfile': (context) => const EditProfile(),
          '/createPost': (context) => const CreatePost(),
          '/editPost': (context) => const EditPost(),
          '/editPostComment': (context) => const EditPostComment(),
          '/viewOtherGroupPost': (context) => const ViewPost(),
          '/map': (context) => const MapView(),
          '/joingroup': (context) => const JoinGroup(),
          '/creategroup': (context) => const CreateGroup(),
          '/managegroup': (context) => const ManageGroup(),
          '/editgroup': (context) => const EditGroup(),
          '/facilities': (context) => FacilitiesContainer(),
          '/registerfacilities': (context) => const RegisterFacilities(),
          '/editfacilities': (context) => const EditFacilities(),
          '/settings': (context) => const SettingsView(),
          '/chat': (context) => const Chat(),
          '/findResidents': (context) => const ResidentsList(),
          '/loading': (context) => Loading(),
          '/emergency': (context) => const Emergency(),
        },
        home: Builder(
          builder: (context) {
            SnackbarService.init(
                ScaffoldMessenger.of(context)); // Initialize SnackbarService
            return const Login();
          },
        ));
  }
}
