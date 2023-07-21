import 'package:etaman_frontend/services/api.dart';
import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/components.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';

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

  String filteredPostListType = 'crime';

  void changeFilteredPostListType(String type) {
    setState(() {
      filteredPostListType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopAppBar(isImplyLeading: false),
        body: Stack(children: [
          Builder(builder: (BuildContext innerContext) {
            return GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! < 0) {
                    Scaffold.of(innerContext).openDrawer();
                  }
                },
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: 12),
                    PostTypeFilterSection(
                        updatePostListType: changeFilteredPostListType,
                        postListType: filteredPostListType),
                    const Divider(height: 0),
                    const SizedBox(height: 10),
                    PostList(postListType: filteredPostListType),
                  ],
                ));
          }),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              backgroundColor: settings.bottomNavBarBgColor,
              onPressed: () {
                // Navigate to create posts screen
                Navigator.pushNamed(context, '/createPost').then((_) {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/home');
                });
              },
              child: Icon(Icons.add, color: settings.bottomNavBarTextColor),
            ),
          )
        ]),
        drawer: const LeftDrawer(),
        bottomNavigationBar: BottomNavBar(selectedIndex: 0));
  }
}
