import 'package:etaman_frontend/services/api.dart';
import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';

class StatusUpdateSection extends StatelessWidget {
  const StatusUpdateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          const CircleAvatar(
            backgroundImage: AssetImage('assets/indonesia.png'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "What's on your mind?",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StoriesSection extends StatelessWidget {
  const StoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/germany.png'),
                  radius: 32,
                ),
                const SizedBox(height: 8),
                Text('User $index'),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Post List Widget
class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('User $index',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('This is a post from User $index'),
              const SizedBox(height: 8),
              Image.asset('assets/usa.png'),
              const SizedBox(height: 8),
              const Row(
                children: <Widget>[
                  Icon(Icons.thumb_up),
                  SizedBox(width: 4),
                  Text('Likes'),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(height: 0),
            ],
          ),
        );
      },
    );
  }
}

// Left Drawer Widget
// ignore: must_be_immutable
class LeftDrawer extends StatefulWidget {
  const LeftDrawer({super.key});

  @override
  LeftDrawerState createState() => LeftDrawerState();
}

class LeftDrawerState extends State<LeftDrawer> {
  ApiService apiService = ApiService();
  AuthService authService = AuthService();
  PopupService popupService = PopupService();
  Settings settings = Settings();

  String name = '';
  String email = '';
  dynamic textColor = Colors.white;
  dynamic bgColor = Colors.white;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    // Set Text and Background Color
    setState(() {
      textColor = settings.leftDrawerTextColor;
    });
    setState(() {
      bgColor = settings.leftDrawerBgColor;
    });
    // Get Resident Account Data
    Map<String, dynamic> tokenData = {"token": authService.getAuthToken()};
    final response = await apiService.getResidentDataAPI(tokenData);
    if (response != null) {
      final status = response["status"];
      if (status > 0) {
        // Success
        final data = response["data"]["list"];
        setState(() {
          name = data["name"];
        });
        setState(() {
          email = data["email"];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              "Welcome, $name",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  color: textColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 18),
            ),
            accountEmail: Text(
              email,
              style: TextStyle(
                  fontFamily: "OpenSans",
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  fontSize: 15),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/germany.png'),
            ),
            decoration: BoxDecoration(color: bgColor),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.black),
            title: const Text('Home',
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w600,
                    fontSize: 18)),
            onTap: () {
              // Handle home screen navigation
              Navigator.pushNamed(context, "/home");
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.black),
            title: const Text('Profile',
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w600,
                    fontSize: 18)),
            onTap: () {
              // Handle profile screen navigation
            },
          ),
          ListTile(
            leading: const Icon(Icons.map, color: Colors.black),
            title: const Text('Map',
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w600,
                    fontSize: 18)),
            onTap: () {
              // Handle neighborhood group screen navigation
            },
          ),
          ListTile(
            leading: const Icon(Icons.group, color: Colors.black),
            title: const Text('Groups',
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w600,
                    fontSize: 18)),
            onTap: () {
              // Handle neighborhood group screen navigation
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.miscellaneous_services, color: Colors.black),
            title: const Text('Facilities',
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w600,
                    fontSize: 18)),
            onTap: () {
              // Handle facilities screen navigation
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.black),
            title: const Text('Settings',
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w600,
                    fontSize: 18)),
            onTap: () {
              // Handle settings screen navigation
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black),
            title: const Text('Logout',
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w600,
                    fontSize: 18)),
            onTap: () async {
              // Handle logout action & navigate to login screen
              final response = await apiService.logoutAccount();
              if (response != null) {
                final status = response["status"];
                final message = response["data"]["message"];
                if (status > 0) {
                  // Success
                  authService.clearAuthToken();
                  // ignore: use_build_context_synchronously
                  popupService
                      .showSuccessPopup(context, "Logout Success", message, () {
                    Navigator.pushNamed(context, '/');
                  });
                } else {
                  // Failed
                  // ignore: use_build_context_synchronously
                  popupService.showErrorPopup(
                      context, "Logout Failed", message, () {});
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

// Top App Bar Widget
// ignore: must_be_immutable
class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  Settings settings = Settings();

  dynamic backgroundColor;
  dynamic textColor;
  final icon = const AssetImage("assets/logo.png");
  final text = "eTaman";

  TopAppBar({super.key}) {
    backgroundColor = settings.topNavBarBgColor;
    textColor = settings.topNavBarTextColor;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      title: Row(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Image(
                image: icon,
                fit: BoxFit.contain,
                width: 90,
                height: 50,
              )),
          const SizedBox(width: 10.0),
          Text(text,
              style: TextStyle(
                  fontFamily: "OpenSans",
                  color: textColor,
                  fontWeight: FontWeight.w800))
        ],
      ),
    );
  }
}

// Bottom Navigation Bar Widget
// ignore: must_be_immutable
class BottomNavBar extends StatelessWidget {
  Settings settings = Settings();

  dynamic backgroundColor;
  dynamic textColor;
  int selectedIndex;

  BottomNavBar({super.key, required this.selectedIndex}) {
    backgroundColor = settings.bottomNavBarBgColor;
    textColor = settings.bottomNavBarTextColor;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: backgroundColor,
          icon: Icon(Icons.home, color: textColor),
          label: "", // Home
        ),
        BottomNavigationBarItem(
          backgroundColor: backgroundColor,
          icon: Icon(Icons.map, color: textColor),
          label: "", // Map
        ),
        BottomNavigationBarItem(
            backgroundColor: backgroundColor,
            icon: Icon(Icons.people, color: textColor),
            label: ""), // Groups
        BottomNavigationBarItem(
            backgroundColor: backgroundColor,
            icon: Icon(Icons.miscellaneous_services, color: textColor),
            label: ""), // Facilities
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            // Navigate to Home Screen
            Navigator.pushNamed(context, "/home");
            break;
          case 1:
            // Navigate to Map Screen
            break;
          case 2:
            // Navigate to Group Screen
            break;
          case 3:
            // Navigate to Facilities Screen
            break;
        }
      },
    );
  }
}
