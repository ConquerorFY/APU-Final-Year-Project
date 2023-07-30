import 'dart:convert';

import 'package:etaman_frontend/services/api.dart';
import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/components.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';

class ViewPost extends StatefulWidget {
  const ViewPost({super.key});

  @override
  ViewPostState createState() => ViewPostState();
}

class ViewPostState extends State<ViewPost> {
  ApiService apiService = ApiService(); // API Service
  PopupService popupService = PopupService(); // Popup Service
  AuthService authService = AuthService(); // Auth Service
  Settings settings = Settings();

  String filteredPostListType = 'crime';
  dynamic pData;
  dynamic uData = {
    "crimePostLikes": [],
    "crimePostDislikes": [],
    "complaintPostLikes": [],
    "complaintPostDislikes": [],
    "eventPostLikes": [],
    "eventPostDislikes": [],
    "generalPostLikes": [],
    "generalPostDislikes": []
  };
  dynamic rID = 0;
  dynamic nID = 0;
  bool bIsJoinedGroup = true;

  @override
  void initState() {
    super.initState();
  }

  void getData(groupID) async {
    // Get All Posts
    final groupResponse = await apiService.getAllPostsAPI();
    if (groupResponse != null) {
      final status = groupResponse["status"];
      if (status > 0) {
        // Success
        // Filter out posts that match the selected group
        dynamic filteredCrimePosts = groupResponse["data"]["crime"]
            .where((post) => post['groupID'] == groupID)
            .toList();
        dynamic filteredComplaintPosts = groupResponse["data"]["complaint"]
            .where((post) => post['groupID'] == groupID)
            .toList();
        dynamic filteredEventPosts = groupResponse["data"]["event"]
            .where((post) => post['groupID'] == groupID)
            .toList();
        dynamic filteredGeneralPosts = groupResponse["data"]["general"]
            .where((post) => post['groupID'] == groupID)
            .toList();

        final data = {
          "crime": filteredCrimePosts,
          "complaint": filteredComplaintPosts,
          "event": filteredEventPosts,
          "general": filteredGeneralPosts
        };
        setState(() {
          pData = data;
        });
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
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final groupID = arguments['groupID'];
    final groupName = arguments['groupName'];
    if (pData == null) {
      getData(groupID);
    }

    return pData != null
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: settings.topNavBarBgColor,
              title: Text('$groupName Group',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      fontFamily: "OpenSans",
                      color: settings.topNavBarTextColor)),
              shadowColor: settings.topNavBarBgColor,
              elevation: 5.0,
            ),
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
            ]),
          )
        : Loading();
  }
}
