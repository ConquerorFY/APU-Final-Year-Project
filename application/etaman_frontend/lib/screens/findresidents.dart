import 'package:etaman_frontend/services/api.dart';
import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';

class ResidentsList extends StatefulWidget {
  const ResidentsList({super.key});

  @override
  ResidentsListState createState() => ResidentsListState();
}

class ResidentsListState extends State<ResidentsList> {
  late List<dynamic> allUsers;
  List<dynamic> displayedUsers = [];
  dynamic loggedInUserID;
  Settings settings = Settings();
  ApiService apiService = ApiService();
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    getData();
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
    final responseData = await apiService.getAllResidentsData();
    if (responseData != null) {
      final status = responseData['status'];
      if (status > 0) {
        // Success
        setState(() {
          allUsers = responseData['data']['list'];
        });
        setState(() {
          // Initialize the displayed users with all users
          displayedUsers = allUsers;
        });
        getLoggedInUserID();
      }
    }
  }

  Future<void> getLoggedInUserID() async {
    final responseData = await apiService
        .getResidentDataAPI({'token': authService.getAuthToken()});
    if (responseData != null) {
      final status = responseData['status'];
      if (status > 0) {
        // Success
        setState(() {
          loggedInUserID = responseData['data']['list']['id'];
        });
      }
    }
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
                          style: TextStyle(
                              color: settings.residentListTextColor,
                              fontFamily: 'OpenSans'),
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
                      displayedUsers.isNotEmpty && loggedInUserID != null
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: displayedUsers.length,
                                itemBuilder: (context, index) {
                                  final user = displayedUsers[index];
                                  return loggedInUserID != user['id']
                                      ? ListTile(
                                          title: Text(user['name'],
                                              style: TextStyle(
                                                  fontFamily: "OpenSans",
                                                  fontSize: 15.0,
                                                  color: settings
                                                      .residentListTextColor,
                                                  fontWeight: FontWeight.w900)),
                                          subtitle: Text(
                                              "${user['username']}#${user['id']}",
                                              style: TextStyle(
                                                  fontFamily: "OpenSans",
                                                  fontSize: 13.0,
                                                  color: settings
                                                      .residentListTextColor,
                                                  fontWeight: FontWeight.w500)),
                                          trailing: Text(user['groupName'],
                                              style: TextStyle(
                                                  fontFamily: "OpenSans",
                                                  fontSize: 10.0,
                                                  color: settings
                                                      .residentListTextColor,
                                                  fontWeight: FontWeight.w800)),
                                          leading: user['image'] != null
                                              ? CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      "${apiService.mediaUrl}${user['image']}"),
                                                )
                                              : const CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: AssetImage(
                                                      "assets/avatar.png"),
                                                ),
                                          onTap: () {
                                            // Select the target resident and show chat messages
                                            Navigator.pop(context,
                                                {'receiverID': user['id']});
                                          },
                                        )
                                      : Container();
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
