import 'dart:convert';

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
  dynamic pData;
  dynamic uData;
  dynamic rID;
  dynamic nID;
  bool bIsJoinedGroup = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    // Get Resident Account Data
    Map<String, dynamic> tokenData = {"token": authService.getAuthToken()};
    final residentResponse = await apiService.getResidentDataAPI(tokenData);
    if (residentResponse != null) {
      final status = residentResponse["status"];
      if (status > 0) {
        // Success
        setState(() {
          nID = residentResponse["data"]["list"]["groupID"];
          rID = residentResponse['data']['list']['id'];
          uData = jsonDecode(residentResponse["data"]["list"]["userData"]);
          bIsJoinedGroup = residentResponse['data']['list']['groupID'] != null;
        });
        // Get Neighborhood Group ID
        final groupID = residentResponse["data"]["list"]["groupID"];
        Map<String, dynamic> groupData = {
          "token": authService.getAuthToken(),
          "groupID": groupID
        };
        final groupResponse =
            await apiService.getAllNeighborhoodPostsAPI(groupData);
        if (groupResponse != null) {
          final status = groupResponse["status"];
          if (status > 0) {
            // Success
            final data = {
              "crime": groupResponse["data"]["crime"],
              "complaint": groupResponse["data"]["complaint"],
              "event": groupResponse["data"]["event"],
              "general": groupResponse["data"]["general"]
            };
            setState(() {
              pData = data;
            });
          }
        }
      }
    }
  }

  void changeFilteredPostListType(String type) {
    setState(() {
      filteredPostListType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return pData != null
        ? Scaffold(
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
                        PostList(
                            postListType: filteredPostListType,
                            postData: pData,
                            isJoinedGroup: bIsJoinedGroup,
                            nGroupID: nID,
                            residentID: rID,
                            userData: uData),
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
            bottomNavigationBar: BottomNavBar(selectedIndex: 0))
        : Loading();
  }
}
