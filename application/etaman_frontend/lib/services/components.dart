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
class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text('John Doe'),
            accountEmail: Text('johndoe@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/germany.png'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Handle home screen navigation
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              // Handle profile screen navigation
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Handle settings screen navigation
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Handle logout action
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
          Text(text, style: TextStyle(fontFamily: "OpenSans", color: textColor))
        ],
      ),
    );
  }
}

// Bottom Navigation Bar Widget
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Friends',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Menu',
        ),
      ],
    );
  }
}
