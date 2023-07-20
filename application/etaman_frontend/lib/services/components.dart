import 'dart:convert';

import 'package:etaman_frontend/services/api.dart';
import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:etaman_frontend/services/utils.dart';
import 'package:flutter/material.dart';

// Post Type Filter Section Widget
class PostTypeFilterSection extends StatefulWidget {
  final Function(String) updatePostListType;
  final String postListType;
  const PostTypeFilterSection(
      {super.key,
      required this.updatePostListType,
      required this.postListType});

  @override
  PostTypeFilterSectionState createState() => PostTypeFilterSectionState();
}

class PostTypeFilterSectionState extends State<PostTypeFilterSection> {
  ApiService apiService = ApiService();
  AuthService authService = AuthService();
  PopupService popupService = PopupService();
  Settings settings = Settings();

  dynamic textColor;
  dynamic iconColor;
  dynamic selectedTextColor;
  dynamic selectedIconColor;

  dynamic crimeIconColor;
  dynamic crimeTextColor;
  dynamic complaintIconColor;
  dynamic complaintTextColor;
  dynamic eventIconColor;
  dynamic eventTextColor;
  dynamic generalIconColor;
  dynamic generalTextColor;

  final postTypes = [
    "Crime Posts",
    "Complaint Posts",
    "Event Posts",
    "General Posts"
  ];

  @override
  void initState() {
    super.initState();
    setColor();
    // Default Selected Post Type When Init
    if (widget.postListType == 'crime') {
      setFilterColor(0);
    } else if (widget.postListType == 'complaint') {
      setFilterColor(1);
    } else if (widget.postListType == 'event') {
      setFilterColor(2);
    } else if (widget.postListType == 'general') {
      setFilterColor(3);
    }
  }

  void setColor() {
    // Set Text & Icon Color
    setState(() {
      textColor = settings.postTypeFilterSectionTextColor;
    });
    setState(() {
      iconColor = settings.postTypeFilterSectionIconColor;
    });
    setState(() {
      selectedTextColor = settings.postTypeFilterSectionTextSelectedColor;
    });
    setState(() {
      selectedIconColor = settings.postTypeFilterSectionIconSelectedColor;
    });
    resetAllColor();
  }

  void resetAllColor() {
    // Set Post Filter Color (Icon and Text)
    setState(() {
      crimeIconColor = iconColor;
    });
    setState(() {
      crimeTextColor = textColor;
    });
    setState(() {
      complaintIconColor = iconColor;
    });
    setState(() {
      complaintTextColor = textColor;
    });
    setState(() {
      eventIconColor = iconColor;
    });
    setState(() {
      eventTextColor = textColor;
    });
    setState(() {
      generalIconColor = iconColor;
    });
    setState(() {
      generalTextColor = textColor;
    });
  }

  void setFilterColor(postType) {
    switch (postType) {
      case 0:
        // Crime Posts
        setState(() {
          crimeIconColor = selectedIconColor;
        });
        setState(() {
          crimeTextColor = selectedTextColor;
        });
        break;
      case 1:
        // Complaint Posts
        setState(() {
          complaintIconColor = selectedIconColor;
        });
        setState(() {
          complaintTextColor = selectedTextColor;
        });
        break;
      case 2:
        // Event Posts
        setState(() {
          eventIconColor = selectedIconColor;
        });
        setState(() {
          eventTextColor = selectedTextColor;
        });
        break;
      case 3:
        // General Posts
        setState(() {
          generalIconColor = selectedIconColor;
        });
        setState(() {
          generalTextColor = selectedTextColor;
        });
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: postTypes.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        // Handle onTap event here
                        resetAllColor();
                        setFilterColor(index);
                        switch (index) {
                          case 0:
                            // When Crime Posts Filter is Clicked
                            widget.updatePostListType('crime');
                            break;
                          case 1:
                            // When Complaint Posts Filter is Clicked
                            widget.updatePostListType('complaint');
                            break;
                          case 2:
                            // When Event Posts Filter is Clicked
                            widget.updatePostListType('event');
                            break;
                          case 3:
                            // When General Posts Filter is Clicked
                            widget.updatePostListType('general');
                            break;
                          default:
                            break;
                        }
                      },
                      child: index == 0
                          ? Icon(Icons.local_police_outlined,
                              color: crimeIconColor, size: 40.0)
                          : index == 1
                              ? Icon(Icons.sentiment_very_dissatisfied,
                                  color: complaintIconColor, size: 40.0)
                              : index == 2
                                  ? Icon(Icons.event,
                                      color: eventIconColor, size: 40.0)
                                  : index == 3
                                      ? Icon(Icons.mail,
                                          color: generalIconColor, size: 40.0)
                                      : null,
                    ),
                    const SizedBox(height: 8),
                    Text(postTypes[index],
                        style: TextStyle(
                          color: index == 0
                              ? crimeTextColor
                              : index == 1
                                  ? complaintTextColor
                                  : index == 2
                                      ? eventTextColor
                                      : index == 3
                                          ? generalTextColor
                                          : null,
                          fontFamily: "OpenSans",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              );
            },
          )),
    );
  }
}

// Post List Widget
class PostList extends StatefulWidget {
  final String postListType;
  const PostList({super.key, required this.postListType});

  @override
  PostListState createState() => PostListState();
}

class PostListState extends State<PostList> {
  ApiService apiService = ApiService();
  AuthService authService = AuthService();
  PopupService popupService = PopupService();
  Utils utils = Utils();
  Settings settings = Settings();

  dynamic textColor;
  dynamic iconColor;
  dynamic iconSelectedColor;
  dynamic buttonColor;
  dynamic buttonCancelColor;
  dynamic postData;
  dynamic userData;
  dynamic commentSectionExpandedState;

  bool isJoinedGroup = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    // Set Text, Background, Button and Cancel Button Color
    setState(() {
      textColor = settings.postListTextColor;
    });
    setState(() {
      iconColor = settings.postListIconColor;
    });
    setState(() {
      iconSelectedColor = settings.postListIconColor2;
    });
    setState(() {
      buttonColor = settings.postListButtonTextColor;
    });
    setState(() {
      buttonCancelColor = settings.postListButtonCancelColor;
    });
    // Get Resident Account Data
    Map<String, dynamic> tokenData = {"token": authService.getAuthToken()};
    final residentResponse = await apiService.getResidentDataAPI(tokenData);
    if (residentResponse != null) {
      final status = residentResponse["status"];
      if (status > 0) {
        // Success
        setState(() {
          userData = jsonDecode(residentResponse["data"]["list"]["userData"]);
          isJoinedGroup = residentResponse['data']['list']['groupID'] != null;
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
              postData = data;
            });
            setState(() {
              commentSectionExpandedState = {
                "crime": List.filled(postData["crime"].length, false),
                "complaint": List.filled(postData["complaint"].length, false),
                "event": List.filled(postData["event"].length, false),
                "general": List.filled(postData["general"].length, false),
              };
            });
          }
        }
      }
    }
  }

  int isLikePostStatus(postType, postID) {
    // 0 -> No Action
    // 1 -> Like
    // -1 -> Dislike
    if (postType == 'crime') {
      final crimePostLikes = userData["crimePostLikes"];
      final crimePostDislikes = userData["crimePostDislikes"];
      if (crimePostLikes.contains(postID) &&
          !(crimePostDislikes.contains(postID))) {
        return 1;
      } else if (crimePostDislikes.contains(postID) &&
          !(crimePostLikes.contains(postID))) {
        return -1;
      }
    } else if (postType == 'complaint') {
      final complaintPostLikes = userData["complaintPostLikes"];
      final complaintPostDislikes = userData["complaintPostDislikes"];
      if (complaintPostLikes.contains(postID) &&
          !(complaintPostDislikes.contains(postID))) {
        return 1;
      } else if (complaintPostDislikes.contains(postID) &&
          !(complaintPostLikes.contains(postID))) {
        return -1;
      }
    } else if (postType == 'event') {
      final eventPostLikes = userData["eventPostLikes"];
      final eventPostDislikes = userData["eventPostDislikes"];
      if (eventPostLikes.contains(postID) &&
          !(eventPostDislikes.contains(postID))) {
        return 1;
      } else if (eventPostDislikes.contains(postID) &&
          !(eventPostLikes.contains(postID))) {
        return -1;
      }
    } else if (postType == 'general') {
      final generalPostLikes = userData["generalPostLikes"];
      final generalPostDislikes = userData["generalPostDislikes"];
      if (generalPostLikes.contains(postID) &&
          !(generalPostDislikes.contains(postID))) {
        return 1;
      } else if (generalPostDislikes.contains(postID) &&
          !(generalPostLikes.contains(postID))) {
        return -1;
      }
    }

    return 0;
  }

  void handleLikeDislikePost(postType, postID, operation) async {
    if (postType == 'crime') {
      if (operation == 'like') {
        final crimePostLikes = userData["crimePostLikes"];
        if (!crimePostLikes.contains(postID)) {
          Map<String, dynamic> postData = {
            "token": authService.getAuthToken(),
            "crimePostID": postID
          };
          final postResponse = await apiService.likeCrimePostAPI(postData);
          if (postResponse != null) {
            final status = postResponse["status"];
            if (status > 0) {
              // Success
              getData();
            }
          }
        }
      } else if (operation == 'dislike') {
        final crimePostDislikes = userData["crimePostDislikes"];
        if (!crimePostDislikes.contains(postID)) {
          Map<String, dynamic> postData = {
            "token": authService.getAuthToken(),
            "crimePostID": postID
          };
          final postResponse = await apiService.dislikeCrimePostAPI(postData);
          if (postResponse != null) {
            final status = postResponse["status"];
            if (status > 0) {
              // Success
              getData();
            }
          }
        }
      }
    } else if (postType == 'complaint') {
      if (operation == 'like') {
        final complaintPostLikes = userData["complaintPostLikes"];
        if (!complaintPostLikes.contains(postID)) {
          Map<String, dynamic> postData = {
            "token": authService.getAuthToken(),
            "complaintPostID": postID
          };
          final postResponse = await apiService.likeComplaintPostAPI(postData);
          if (postResponse != null) {
            final status = postResponse["status"];
            if (status > 0) {
              // Success
              getData();
            }
          }
        }
      } else if (operation == 'dislike') {
        final complaintPostDislikes = userData["complaintPostDislikes"];
        if (!complaintPostDislikes.contains(postID)) {
          Map<String, dynamic> postData = {
            "token": authService.getAuthToken(),
            "complaintPostID": postID
          };
          final postResponse =
              await apiService.dislikeComplaintPostAPI(postData);
          if (postResponse != null) {
            final status = postResponse["status"];
            if (status > 0) {
              // Success
              getData();
            }
          }
        }
      }
    } else if (postType == 'event') {
      if (operation == 'like') {
        final eventPostLikes = userData["eventPostLikes"];
        if (!eventPostLikes.contains(postID)) {
          Map<String, dynamic> postData = {
            "token": authService.getAuthToken(),
            "eventPostID": postID
          };
          final postResponse = await apiService.likeEventPostAPI(postData);
          if (postResponse != null) {
            final status = postResponse["status"];
            if (status > 0) {
              // Success
              getData();
            }
          }
        }
      } else if (operation == 'dislike') {
        final eventPostDislikes = userData["eventPostDislikes"];
        if (!eventPostDislikes.contains(postID)) {
          Map<String, dynamic> postData = {
            "token": authService.getAuthToken(),
            "eventPostID": postID
          };
          final postResponse = await apiService.dislikeEventPostAPI(postData);
          if (postResponse != null) {
            final status = postResponse["status"];
            if (status > 0) {
              // Success
              getData();
            }
          }
        }
      }
    } else if (postType == 'general') {
      if (operation == 'like') {
        final generalPostLikes = userData["generalPostLikes"];
        if (!generalPostLikes.contains(postID)) {
          Map<String, dynamic> postData = {
            "token": authService.getAuthToken(),
            "generalPostID": postID
          };
          final postResponse = await apiService.likeGeneralPostAPI(postData);
          if (postResponse != null) {
            final status = postResponse["status"];
            if (status > 0) {
              // Success
              getData();
            }
          }
        }
      } else if (operation == 'dislike') {
        final generalPostDislikes = userData["generalPostDislikes"];
        if (!generalPostDislikes.contains(postID)) {
          Map<String, dynamic> postData = {
            "token": authService.getAuthToken(),
            "generalPostID": postID
          };
          final postResponse = await apiService.dislikeGeneralPostAPI(postData);
          if (postResponse != null) {
            final status = postResponse["status"];
            if (status > 0) {
              // Success
              getData();
            }
          }
        }
      }
    }
  }

  Widget displayCrimePosts(context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: postData["crime"].length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.fromLTRB(30, 16, 30, 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.local_police_outlined, color: iconColor, size: 15),
                const SizedBox(height: 5),
                Text(postData["crime"][index]["title"],
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: textColor)),
                const SizedBox(height: 15),
                Text(postData["crime"][index]["description"],
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textColor)),
                const SizedBox(height: 10),
                postData["crime"][index]["image"] != null
                    ? Image.network(
                        "${apiService.mediaUrl}${postData["crime"][index]["image"]}",
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Text('Error Loading Image',
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: textColor));
                        },
                      )
                    : Image.asset('assets/stock_crime_image.png',
                        width: double.infinity),
                const SizedBox(height: 15),
                Text("Posted By: ${postData['crime'][index]['username']}",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: textColor)),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: [
                        GestureDetector(
                          onTap: () {
                            // Handle Like Crime Post Operation
                            handleLikeDislikePost("crime",
                                postData["crime"][index]["id"], "like");
                          },
                          child: Icon(Icons.thumb_up,
                              size: 20,
                              color: isLikePostStatus("crime",
                                          postData['crime'][index]['id']) ==
                                      1
                                  ? iconSelectedColor
                                  : iconColor),
                        ),
                        const SizedBox(width: 4),
                        Text(postData["crime"][index]["likes"].toString(),
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textColor))
                      ]),
                      Row(children: [
                        GestureDetector(
                          onTap: () {
                            // Handle Dislike Crime Post Operation
                            handleLikeDislikePost("crime",
                                postData["crime"][index]["id"], "dislike");
                          },
                          child: Icon(Icons.thumb_down,
                              size: 20,
                              color: isLikePostStatus("crime",
                                          postData['crime'][index]['id']) ==
                                      -1
                                  ? iconSelectedColor
                                  : iconColor),
                        ),
                        const SizedBox(width: 4),
                        Text(postData["crime"][index]["dislikes"].toString(),
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textColor)),
                      ]),
                    ]),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      commentSectionExpandedState["crime"][index] =
                          !commentSectionExpandedState["crime"][index];
                    });
                  },
                  child: Row(
                    children: [
                      Text('Comments',
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textColor)),
                      Icon(
                          commentSectionExpandedState["crime"][index]
                              ? Icons.expand_less
                              : Icons.expand_more,
                          color: iconColor,
                          size: 20),
                    ],
                  ),
                ),
                Visibility(
                  visible: commentSectionExpandedState["crime"][index],
                  child: PostComments(
                      postType: widget.postListType,
                      postID: postData["crime"][index]["id"]),
                ),
                const SizedBox(height: 16),
                const Divider(height: 0),
              ]),
        );
      },
    );
  }

  Widget displayComplaintPosts(context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: postData["complaint"].length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.fromLTRB(30, 16, 30, 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.sentiment_very_dissatisfied,
                    color: iconColor, size: 15),
                const SizedBox(height: 5),
                Text(postData["complaint"][index]["title"],
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: textColor)),
                const SizedBox(height: 15),
                Text("To: ${postData['complaint'][index]['target']}",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: textColor)),
                const SizedBox(height: 5),
                Text(postData["complaint"][index]["description"],
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textColor)),
                const SizedBox(height: 10),
                postData["complaint"][index]["image"] != null
                    ? Image.network(
                        "${apiService.mediaUrl}${postData["complaint"][index]["image"]}",
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Text('Error Loading Image',
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: textColor));
                        },
                      )
                    : Image.asset('assets/stock_complaint_image.png',
                        width: double.infinity),
                const SizedBox(height: 15),
                Text(
                    "Posted By: ${!postData['complaint'][index]['isAnonymous'] ? postData['complaint'][index]['username'] : '-'}",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: textColor)),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: [
                        GestureDetector(
                          onTap: () {
                            // Handle Like Complaint Post Operation
                            handleLikeDislikePost("complaint",
                                postData["complaint"][index]["id"], "like");
                          },
                          child: Icon(Icons.thumb_up,
                              size: 20,
                              color: isLikePostStatus("complaint",
                                          postData['complaint'][index]['id']) ==
                                      1
                                  ? iconSelectedColor
                                  : iconColor),
                        ),
                        const SizedBox(width: 4),
                        Text(postData["complaint"][index]["likes"].toString(),
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textColor))
                      ]),
                      Row(children: [
                        GestureDetector(
                          onTap: () {
                            // Handle Dislike Complaint Post Operation
                            handleLikeDislikePost("complaint",
                                postData["complaint"][index]["id"], "dislike");
                          },
                          child: Icon(Icons.thumb_down,
                              size: 20,
                              color: isLikePostStatus("complaint",
                                          postData['complaint'][index]['id']) ==
                                      -1
                                  ? iconSelectedColor
                                  : iconColor),
                        ),
                        const SizedBox(width: 4),
                        Text(
                            postData["complaint"][index]["dislikes"].toString(),
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textColor)),
                      ]),
                    ]),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      commentSectionExpandedState["complaint"][index] =
                          !commentSectionExpandedState["complaint"][index];
                    });
                  },
                  child: Row(
                    children: [
                      Text('Comments',
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textColor)),
                      Icon(
                          commentSectionExpandedState["complaint"][index]
                              ? Icons.expand_less
                              : Icons.expand_more,
                          color: iconColor,
                          size: 20),
                    ],
                  ),
                ),
                Visibility(
                  visible: commentSectionExpandedState["complaint"][index],
                  child: PostComments(
                      postType: widget.postListType,
                      postID: postData["complaint"][index]["id"]),
                ),
                const SizedBox(height: 16),
                const Divider(height: 0),
              ]),
        );
      },
    );
  }

  ElevatedButton createJoinLeaveEventButton(context, index) {
    return !postData["event"][index]["hasJoined"]
        ? ElevatedButton(
            onPressed: () async {
              // Join the event
              Map<String, dynamic> joinEventData = {
                "eventPostID": postData["event"][index]["id"],
                "token": authService.getAuthToken()
              };
              final joinEventResponse =
                  await apiService.joinEventPostAPI(joinEventData);
              if (joinEventResponse != null) {
                final status = joinEventResponse["status"];
                if (status > 0) {
                  // Success
                  final message = joinEventResponse['data']['message'];
                  // ignore: use_build_context_synchronously
                  popupService.showSuccessPopup(
                      context, "Join Event Success", message, () {
                    getData();
                  });
                } else {
                  // Error
                  final message = joinEventResponse['data']['message'];
                  // ignore: use_build_context_synchronously
                  popupService.showErrorPopup(
                      context, "Join Event Failed", message, () {});
                }
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(textColor)),
            child: Text("Join Event",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: buttonColor)),
          )
        : ElevatedButton(
            onPressed: () async {
              // Join the event
              Map<String, dynamic> leaveEventData = {
                "eventPostID": postData["event"][index]["id"],
                "token": authService.getAuthToken()
              };
              final leaveEventResponse =
                  await apiService.leaveEventPostAPI(leaveEventData);
              if (leaveEventResponse != null) {
                final status = leaveEventResponse["status"];
                if (status > 0) {
                  // Success
                  final message = leaveEventResponse['data']['message'];
                  // ignore: use_build_context_synchronously
                  popupService.showSuccessPopup(
                      context, "Leave Event Success", message, () {
                    getData();
                  });
                } else {
                  // Error
                  final message = leaveEventResponse['data']['message'];
                  // ignore: use_build_context_synchronously
                  popupService.showErrorPopup(
                      context, "Leave Event Failed", message, () {});
                }
              }
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(buttonCancelColor)),
            child: Text("Leave Event",
                style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: buttonColor)),
          );
  }

  Widget displayEventPosts(context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: postData["event"].length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.fromLTRB(30, 16, 30, 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.event, color: iconColor, size: 15),
                const SizedBox(height: 5),
                Text(postData["event"][index]["title"],
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: textColor)),
                const SizedBox(height: 15),
                Text(
                    "Time: ${utils.formatDateTime(postData['event'][index]['datetime'])}",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: textColor)),
                const SizedBox(height: 5),
                Text("Venue: ${postData['event'][index]['venue']}",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: textColor)),
                const SizedBox(height: 5),
                Text(
                    "Total Participants: ${jsonDecode(postData['event'][index]['participants']).length}",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: textColor)),
                const SizedBox(height: 10),
                Text(postData["event"][index]["description"],
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textColor)),
                const SizedBox(height: 10),
                postData["event"][index]["image"] != null
                    ? Image.network(
                        "${apiService.mediaUrl}${postData["event"][index]["image"]}",
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Text('Error Loading Image',
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: textColor));
                        },
                      )
                    : Image.asset('assets/stock_event_image.png',
                        width: double.infinity),
                const SizedBox(height: 15),
                Text("Posted By: ${postData['event'][index]['username']}",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: textColor)),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: [
                        GestureDetector(
                          onTap: () {
                            // Handle Like Event Post Operation
                            handleLikeDislikePost("event",
                                postData["event"][index]["id"], "like");
                          },
                          child: Icon(Icons.thumb_up,
                              size: 20,
                              color: isLikePostStatus("event",
                                          postData['event'][index]['id']) ==
                                      1
                                  ? iconSelectedColor
                                  : iconColor),
                        ),
                        const SizedBox(width: 4),
                        Text(postData["event"][index]["likes"].toString(),
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textColor))
                      ]),
                      createJoinLeaveEventButton(context, index),
                      Row(children: [
                        GestureDetector(
                          onTap: () {
                            // Handle Dislike Event Post Operation
                            handleLikeDislikePost("event",
                                postData["event"][index]["id"], "dislike");
                          },
                          child: Icon(Icons.thumb_down,
                              size: 20,
                              color: isLikePostStatus("event",
                                          postData['event'][index]['id']) ==
                                      -1
                                  ? iconSelectedColor
                                  : iconColor),
                        ),
                        const SizedBox(width: 4),
                        Text(postData["event"][index]["dislikes"].toString(),
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textColor)),
                      ]),
                    ]),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      commentSectionExpandedState["event"][index] =
                          !commentSectionExpandedState["event"][index];
                    });
                  },
                  child: Row(
                    children: [
                      Text('Comments',
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textColor)),
                      Icon(
                          commentSectionExpandedState["event"][index]
                              ? Icons.expand_less
                              : Icons.expand_more,
                          color: iconColor,
                          size: 20),
                    ],
                  ),
                ),
                Visibility(
                  visible: commentSectionExpandedState["event"][index],
                  child: PostComments(
                      postType: widget.postListType,
                      postID: postData["event"][index]["id"]),
                ),
                const SizedBox(height: 16),
                const Divider(height: 0),
              ]),
        );
      },
    );
  }

  Widget displayGeneralPosts(context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: postData["general"].length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.fromLTRB(30, 16, 30, 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.mail, color: iconColor, size: 15),
                const SizedBox(height: 5),
                Text(postData["general"][index]["title"],
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: textColor)),
                const SizedBox(height: 15),
                Text(postData["general"][index]["description"],
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textColor)),
                const SizedBox(height: 10),
                postData["general"][index]["image"] != null
                    ? Image.network(
                        "${apiService.mediaUrl}${postData["general"][index]["image"]}",
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Text('Error Loading Image',
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: textColor));
                        },
                      )
                    : Image.asset('assets/stock_general_image.png',
                        width: double.infinity),
                const SizedBox(height: 15),
                Text("Posted By: ${postData['general'][index]['username']}",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: textColor)),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: [
                        GestureDetector(
                          onTap: () {
                            // Handle Like General Post Operation
                            handleLikeDislikePost("general",
                                postData["general"][index]["id"], "like");
                          },
                          child: Icon(Icons.thumb_up,
                              size: 20,
                              color: isLikePostStatus("general",
                                          postData['general'][index]['id']) ==
                                      1
                                  ? iconSelectedColor
                                  : iconColor),
                        ),
                        const SizedBox(width: 4),
                        Text(postData["general"][index]["likes"].toString(),
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textColor))
                      ]),
                      Row(children: [
                        GestureDetector(
                          onTap: () {
                            // Handle Dislike General Post Operation
                            handleLikeDislikePost("general",
                                postData["general"][index]["id"], "dislike");
                          },
                          child: Icon(Icons.thumb_down,
                              size: 20,
                              color: isLikePostStatus("general",
                                          postData['general'][index]['id']) ==
                                      -1
                                  ? iconSelectedColor
                                  : iconColor),
                        ),
                        const SizedBox(width: 4),
                        Text(postData["general"][index]["dislikes"].toString(),
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textColor)),
                      ]),
                    ]),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      commentSectionExpandedState["general"][index] =
                          !commentSectionExpandedState["general"][index];
                    });
                  },
                  child: Row(
                    children: [
                      Text('Comments',
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textColor)),
                      Icon(
                          commentSectionExpandedState["general"][index]
                              ? Icons.expand_less
                              : Icons.expand_more,
                          color: iconColor,
                          size: 20),
                    ],
                  ),
                ),
                Visibility(
                  visible: commentSectionExpandedState["general"][index],
                  child: PostComments(
                      postType: widget.postListType,
                      postID: postData["general"][index]["id"]),
                ),
                const SizedBox(height: 16),
                const Divider(height: 0),
              ]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isJoinedGroup) {
      switch (widget.postListType) {
        case "crime":
          return displayCrimePosts(context);
        case "complaint":
          return displayComplaintPosts(context);
        case "event":
          return displayEventPosts(context);
        case "general":
          return displayGeneralPosts(context);
        default:
          break;
      }
    }

    return Container();
  }
}

// Post Comment Widget
class PostComments extends StatefulWidget {
  final String postType;
  final int postID;
  const PostComments({super.key, required this.postType, required this.postID});

  @override
  PostCommentsState createState() => PostCommentsState();
}

class PostCommentsState extends State<PostComments> {
  ApiService apiService = ApiService();
  AuthService authService = AuthService();
  PopupService popupService = PopupService();
  Settings settings = Settings();

  dynamic textColor;
  dynamic iconColor;

  dynamic comments;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setTextIconColors();
    getComments();
  }

  void setTextIconColors() {
    setState(() {
      textColor = settings.postListTextColor;
    });
    setState(() {
      iconColor = settings.postListIconColor;
    });
  }

  void getComments() async {
    // Get Post Comments Data
    if (widget.postType == 'crime') {
      // Crime Post Comments
      Map<String, dynamic> crimePostData = {"crimePostID": widget.postID};
      final crimeResponse =
          await apiService.getAllCrimePostCommentsAPI(crimePostData);
      if (crimeResponse != null) {
        final status = crimeResponse["status"];
        if (status > 0) {
          // Success
          // Get Crime Post Comments
          setState(() {
            comments = crimeResponse["data"]["comments"];
          });
        }
      }
    } else if (widget.postType == 'complaint') {
      // Complaint Post Comments
      Map<String, dynamic> complaintPostData = {
        "complaintPostID": widget.postID
      };
      final complaintResponse =
          await apiService.getAllComplaintPostCommentsAPI(complaintPostData);
      if (complaintResponse != null) {
        final status = complaintResponse["status"];
        if (status > 0) {
          // Success
          // Get Complaint Post Comments
          setState(() {
            comments = complaintResponse["data"]["comments"];
          });
        }
      }
    } else if (widget.postType == 'event') {
      // Event Post Comments
      Map<String, dynamic> eventPostData = {"eventPostID": widget.postID};
      final eventResponse =
          await apiService.getAllEventPostCommentsAPI(eventPostData);
      if (eventResponse != null) {
        final status = eventResponse["status"];
        if (status > 0) {
          // Success
          // Get Event Post Comments
          setState(() {
            comments = eventResponse["data"]["comments"];
          });
        }
      }
    } else if (widget.postType == 'general') {
      // General Post Comments
      Map<String, dynamic> generalPostData = {"generalPostID": widget.postID};
      final generalResponse =
          await apiService.getAllGeneralPostCommentsAPI(generalPostData);
      if (generalResponse != null) {
        final status = generalResponse["status"];
        if (status > 0) {
          // Success
          // Get General Post Comments
          setState(() {
            comments = generalResponse["data"]["comments"];
          });
        }
      }
    }
  }

  void submitComment() async {
    String newComment = commentController.text;
    int postID = widget.postID;
    String token = authService.getAuthToken();

    if (widget.postType == 'crime') {
      // Submit crime post comments
      Map<String, dynamic> commentData = {
        "content": newComment,
        "crimePostID": postID,
        "token": token
      };
      final commentResponse =
          await apiService.submitCrimePostCommentAPI(commentData);
      if (commentResponse != null) {
        final status = commentResponse["status"];
        if (status > 0) {
          // Success
          setState(() {
            commentController.clear();
          });
          getComments();
        }
      }
    } else if (widget.postType == 'complaint') {
      // Submit complaint post comments
      Map<String, dynamic> commentData = {
        "content": newComment,
        "complaintPostID": postID,
        "token": token
      };
      final commentResponse =
          await apiService.submitComplaintPostCommentAPI(commentData);
      if (commentResponse != null) {
        final status = commentResponse["status"];
        if (status > 0) {
          // Success
          setState(() {
            commentController.clear();
          });
          getComments();
        }
      }
    } else if (widget.postType == 'event') {
      // Submit event post comments
      Map<String, dynamic> commentData = {
        "content": newComment,
        "eventPostID": postID,
        "token": token
      };
      final commentResponse =
          await apiService.submitEventPostCommentAPI(commentData);
      if (commentResponse != null) {
        final status = commentResponse["status"];
        if (status > 0) {
          // Success
          setState(() {
            commentController.clear();
          });
          getComments();
        }
      }
    } else if (widget.postType == 'general') {
      // Submit general post comments
      Map<String, dynamic> commentData = {
        "content": newComment,
        "generalPostID": postID,
        "token": token
      };
      final commentResponse =
          await apiService.submitGeneralPostCommentAPI(commentData);
      if (commentResponse != null) {
        final status = commentResponse["status"];
        if (status > 0) {
          // Success
          setState(() {
            commentController.clear();
          });
          getComments();
        }
      }
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: commentController,
          style: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: textColor),
          decoration: InputDecoration(
            hintText: 'Add a comment...',
            labelStyle: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: textColor),
            suffixIcon: IconButton(
              icon: Icon(Icons.send, color: iconColor, size: 20),
              onPressed: submitComment,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${comments[index]['username']}: ${comments[index]['content']}",
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: textColor)),
                      const SizedBox(height: 10),
                    ]);
              },
            )),
      ],
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
              Navigator.pushNamed(context, "/home").then((_) {
                getData();
              });
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
              Navigator.pushNamed(context, '/profile').then((_) {
                getData();
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.map, color: Colors.black),
            title: const Text('Map & Groups',
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
              final response = await apiService.logoutAccountAPI();
              if (response != null) {
                final status = response["status"];
                final message = response["data"]["message"];
                if (status > 0) {
                  // Success
                  authService.clearAuthToken();
                  // ignore: use_build_context_synchronously
                  popupService
                      .showSuccessPopup(context, "Logout Success", message, () {
                    Navigator.pushNamed(context, '/').then((_) {
                      getData();
                    });
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
  dynamic isImplyLeading;
  final icon = const AssetImage("assets/logo.png");
  final text = "eTaman";

  TopAppBar({super.key, this.isImplyLeading}) {
    backgroundColor = settings.topNavBarBgColor;
    textColor = settings.topNavBarTextColor;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: isImplyLeading,
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
          label: "", // Map & Groups
        ),
        BottomNavigationBarItem(
            backgroundColor: backgroundColor,
            icon: Icon(Icons.miscellaneous_services, color: textColor),
            label: ""), // Facilities
        BottomNavigationBarItem(
            backgroundColor: backgroundColor,
            icon: Icon(Icons.settings, color: textColor),
            label: ""), // Settings
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            // Navigate to Home Screen
            Navigator.pushNamed(context, "/home");
            break;
          case 1:
            // Navigate to Map & Groups Screen
            Navigator.pushNamed(context, "/map");
            break;
          case 2:
            // Navigate to Facilities Screen
            break;
          case 3:
            // Navigate to Settings Screen
            break;
        }
      },
    );
  }
}
