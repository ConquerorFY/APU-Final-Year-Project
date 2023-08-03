import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';

class ResidentsList extends StatefulWidget {
  const ResidentsList({super.key});

  @override
  ResidentsListState createState() => ResidentsListState();
}

class ResidentsListState extends State<ResidentsList> {
  final List<Map> allUsers = [
    {'name': 'Ryan Lim Fang Yung', 'username': 'ryan', 'group': 'Ampang Gang'},
    {'name': 'Andrew', 'username': 'andrew', 'group': 'Ampang Gang'},
    // Add more users
  ];
  List<Map> displayedUsers = [];
  Settings settings = Settings();

  @override
  void initState() {
    super.initState();
    displayedUsers = allUsers; // Initialize the displayed users with all users
  }

  void filterUsers(String query) {
    setState(() {
      displayedUsers = allUsers
          .where((user) =>
              user['username'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> getData() async {
    int a = await 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: settings.residentListBgColor,
          title: Text('Residents List',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  fontFamily: "OpenSans",
                  color: settings.residentListTextColor2)),
          shadowColor: settings.residentListTextShadowColor,
          elevation: 5.0,
        ),
        body: RefreshIndicator(
            onRefresh: getData,
            color: settings.loadingBgColor,
            child: FutureBuilder(
                future: Future.delayed(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                          onChanged: filterUsers,
                          cursorColor: settings.residentListTextColor,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: settings.residentListBorderColor,
                                    width: settings.residentListBorderWidth)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: settings.residentListBorderColor,
                                    width: settings.residentListBorderWidth +
                                        1.0)),
                            hintText: 'Search by username...',
                            prefixIcon: Icon(Icons.search,
                                color: settings.residentListIconColor),
                          ),
                        ),
                      ),
                      displayedUsers.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: displayedUsers.length,
                                itemBuilder: (context, index) {
                                  final user = displayedUsers[index];
                                  return ListTile(
                                    title: Text(user['name'],
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            fontSize: 15.0,
                                            color:
                                                settings.residentListTextColor,
                                            fontWeight: FontWeight.w900)),
                                    subtitle: Text(user['username'],
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            fontSize: 13.0,
                                            color:
                                                settings.residentListTextColor,
                                            fontWeight: FontWeight.w500)),
                                    trailing: Text(user['group'],
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            fontSize: 10.0,
                                            color:
                                                settings.residentListTextColor,
                                            fontWeight: FontWeight.w800)),
                                    leading: IconButton(
                                      icon: Icon(Icons.arrow_forward_ios,
                                          color: settings.residentListIconColor,
                                          size: 20.0),
                                      onPressed: () {
                                        // Perform action when the button/icon is pressed
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  padding: const EdgeInsets.all(16.0),
                                  itemCount: 1,
                                  itemBuilder: ((context, index) {
                                    return Center(
                                        child: Text("No residents found!",
                                            style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                color: settings
                                                    .residentListTextColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700)));
                                  }))),
                    ],
                  );
                })));
  }
}
