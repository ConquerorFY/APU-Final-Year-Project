import 'package:etaman_frontend/services/api.dart';
import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';

// Post Type Filter Section Widget
class PostTypeFilterSection extends StatefulWidget {
  final Function(String) updatePostListType;
  const PostTypeFilterSection({super.key, required this.updatePostListType});

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
    // Initially Crime Posts Is Selected
    setState(() {
      crimeIconColor = selectedIconColor;
    });
    setState(() {
      crimeTextColor = selectedTextColor;
    });
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
  Settings settings = Settings();

  dynamic textColor;
  dynamic iconColor;
  dynamic postData;
  dynamic commentSectionExpandedState;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    // Set Text and Background Color
    setState(() {
      textColor = settings.postListTextColor;
    });
    setState(() {
      iconColor = settings.postListIconColor;
    });
    // Get Resident Account Data
    Map<String, dynamic> tokenData = {"token": authService.getAuthToken()};
    final residentResponse = await apiService.getResidentDataAPI(tokenData);
    if (residentResponse != null) {
      final status = residentResponse["status"];
      if (status > 0) {
        // Success
        // Get Neighborhood Group ID
        final groupID = residentResponse["data"]["list"]["groupID"];
        Map<String, dynamic> groupData = {"groupID": groupID};
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
                const SizedBox(height: 10),
                Text(postData["crime"][index]["description"],
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textColor)),
                const SizedBox(height: 10),
                Image.asset('assets/usa.png', width: double.infinity),
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
                        Icon(Icons.thumb_up, size: 20, color: iconColor),
                        const SizedBox(width: 4),
                        Text(postData["crime"][index]["likes"].toString(),
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textColor))
                      ]),
                      Row(children: [
                        Icon(Icons.thumb_down, size: 20, color: iconColor),
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

  @override
  Widget build(BuildContext context) {
    switch (widget.postListType) {
      case "crime":
        return displayCrimePosts(context);
      case "complaint":
        break;
      case "event":
        break;
      case "general":
        break;
      default:
        break;
    }

    return const Scaffold();
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
