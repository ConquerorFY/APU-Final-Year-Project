import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';
import '../services/api.dart';
import '../services/auth.dart';
import '../services/popup.dart';
import '../services/components.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  ApiService apiService = ApiService(); // API Service
  PopupService popupService = PopupService(); // Popup Service
  AuthService authService = AuthService(); // Auth Service
  Settings settings = Settings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopAppBar(),
        body: Builder(builder: (BuildContext innerContext) {
          return GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! < 0) {
                  Scaffold.of(innerContext).openDrawer();
                }
              },
              child: ListView(
                children: const <Widget>[
                  StatusUpdateSection(),
                  Divider(height: 0),
                  StoriesSection(),
                  Divider(height: 0),
                  PostList(),
                ],
              ));
        }),
        drawer: const LeftDrawer(),
        bottomNavigationBar: const BottomNavBar());
  }
}
