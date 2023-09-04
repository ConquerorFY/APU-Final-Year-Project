import 'package:etaman_frontend/services/api.dart';
import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:etaman_frontend/services/validator.dart';
import 'package:flutter/material.dart';

class JoinGroup extends StatefulWidget {
  const JoinGroup({super.key});

  @override
  JoinGroupState createState() => JoinGroupState();
}

class JoinGroupState extends State<JoinGroup> {
  List<dynamic> groupData = [];
  List<dynamic> filteredGroupData = [];
  List<dynamic> joinRequestsData = [];
  bool isAvailableGroupList = true;
  bool isJoinedGroup = false;
  int? targetGroupID;
  bool isEditing = false;
  String filterGroupName = '';
  String appBarTitle = "Search Group";

  Validator validator = Validator();
  ApiService apiService = ApiService();
  PopupService popupService = PopupService();
  AuthService authService = AuthService();
  Settings settings = Settings();

  void toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
      if (isEditing) {
        appBarTitle = '';
        filterGroupName = appBarTitle;
      } else {
        appBarTitle = filterGroupName;
      }
    });
  }

  dynamic filterGroupData(val) {
    return groupData.where((group) {
      return group['name'].toLowerCase().contains(val) ||
          group['state'].toLowerCase().contains(val) ||
          group['city'].toLowerCase().contains(val) ||
          group['street'].toLowerCase().contains(val) ||
          group['postcode'].toString().toLowerCase().contains(val);
    }).toList();
  }

  void joinGroup(group) {
    // Implement your logic to join the selected group here
    print('Joining group: ${group['name']}');
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void resetState() {
    setState(() {
      isAvailableGroupList = true;
      isJoinedGroup = false;
      targetGroupID = null;
    });
  }

  Future<void> getData() async {
    final groupResponse = await apiService.getAllNeighborhoodGroupsAPI();
    if (groupResponse != null) {
      final status = groupResponse['status'];
      if (status > 0) {
        // Success
        setState(() {
          groupData = groupResponse['data']['list'];
        });
        setState(() {
          filteredGroupData = groupResponse['data']['list'];
        });
        getAllJoinRequests();
      }
    }
  }

  void getAllJoinRequests() async {
    final joinResponse =
        await apiService.getAllNeighborhoodGroupsJoinRequestAPI();
    if (joinResponse != null) {
      final status = joinResponse['status'];
      if (status > 0) {
        // Success
        setState(() {
          joinRequestsData = joinResponse['data']['list'];
        });
        getResidentGroupIsJoinedStatus();
      }
    }
  }

  void getResidentGroupIsJoinedStatus() async {
    final residentResponse = await apiService
        .getResidentDataAPI({"token": authService.getAuthToken()});
    if (residentResponse != null) {
      final status = residentResponse['status'];
      if (status > 0) {
        // Success
        resetState();
        final groupID = residentResponse['data']['list']['groupID'];
        final residentID = residentResponse['data']['list']['id'];
        // Check whether resident has already joined a group
        if (groupID != null) {
          setState(() {
            isAvailableGroupList = false;
            targetGroupID = groupID;
            isJoinedGroup = true;
          });
        }
        // Check whether resident has made a join request to group
        for (var request in joinRequestsData) {
          if (request['residentID'] == residentID) {
            setState(() {
              isAvailableGroupList = false;
              targetGroupID = request['groupID'];
              isJoinedGroup = false;
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the crossAxisCount based on the phone width
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth ~/ 160; // Adjust the divisor as needed

    return Scaffold(
        appBar: AppBar(
          backgroundColor: settings.editProfileBgColor,
          title: isEditing
              ? TextField(
                  cursorColor: settings.joinGroupTextFieldTextColor,
                  autofocus: true,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: "OpenSans",
                      color: settings.editProfileTextFieldText2Color),
                  decoration: InputDecoration(
                      focusColor: settings.joinGroupTextFieldTextColor,
                      labelText: 'Enter Group Name...',
                      labelStyle: TextStyle(
                          color: settings.joinGroupTextFieldTextColor),
                      border: InputBorder.none),
                  onSubmitted: (val) {
                    setState(() {
                      filterGroupName = val;
                      filteredGroupData =
                          filterGroupData(filterGroupName.toLowerCase());
                    });
                    toggleEditMode();
                  },
                )
              : GestureDetector(
                  onTap: toggleEditMode,
                  child: Row(
                    children: [
                      Icon(Icons.search,
                          color: settings.joinGroupTextFieldTextColor),
                      const SizedBox(width: 10.0),
                      Text(appBarTitle,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              fontFamily: "OpenSans",
                              color: settings.joinGroupTextFieldTextColor))
                    ],
                  ),
                ),
          shadowColor: settings.joinGroupTextFieldShadowColor,
          elevation: 5.0,
        ),
        body: RefreshIndicator(
            color: settings.loadingBgColor,
            onRefresh: getData,
            child: FutureBuilder(
                future: Future.delayed(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Stack(children: [
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: filteredGroupData.isNotEmpty
                            ? GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  mainAxisSpacing: 20.0,
                                  crossAxisSpacing: 10.0,
                                ),
                                itemCount: filteredGroupData.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () =>
                                        joinGroup(filteredGroupData[index]),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: settings.joinGroupBgColor,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 16, 20, 16),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  filteredGroupData[index]
                                                      ['name'],
                                                  style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      color: settings
                                                          .joinGroupTextFieldTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w800)),
                                              const SizedBox(height: 10.0),
                                              Text("Address",
                                                  style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      color: settings
                                                          .joinGroupTextFieldTextColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor: settings
                                                          .joinGroupTextFieldTextColor,
                                                      decorationThickness:
                                                          2.0)),
                                              const SizedBox(height: 4.0),
                                              Text(
                                                  "${filteredGroupData[index]['street']}, ${filteredGroupData[index]['postcode']} ${filteredGroupData[index]['city']}, ${filteredGroupData[index]['state']}",
                                                  style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      color: settings
                                                          .joinGroupTextFieldTextColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              const SizedBox(height: 10.0),
                                              Text("Rules",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      color: settings
                                                          .joinGroupTextFieldTextColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor: settings
                                                          .joinGroupTextFieldTextColor,
                                                      decorationThickness:
                                                          2.0)),
                                              const SizedBox(height: 4.0),
                                              Text(
                                                  "${filteredGroupData[index]['rules'].length > 0 ? filteredGroupData[index]['rules'] : '-'}",
                                                  style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      color: settings
                                                          .joinGroupTextFieldTextColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              const SizedBox(height: 10.0),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    if (isAvailableGroupList) {
                                                      // Resident has not joined any group
                                                      Map<String, dynamic>
                                                          joinData = {
                                                        "groupId":
                                                            filteredGroupData[
                                                                index]['id'],
                                                        "token": authService
                                                            .getAuthToken()
                                                      };
                                                      final joinResponse =
                                                          await apiService
                                                              .submitJoinGroupRequestAPI(
                                                                  joinData);
                                                      if (joinResponse !=
                                                          null) {
                                                        final status =
                                                            joinResponse[
                                                                'status'];
                                                        if (status > 0) {
                                                          // Success
                                                          final message =
                                                              joinResponse[
                                                                      'data']
                                                                  ['message'];
                                                          // ignore: use_build_context_synchronously
                                                          popupService
                                                              .showSuccessPopup(
                                                                  context,
                                                                  "Join Request Success",
                                                                  message, () {
                                                            getData();
                                                          });
                                                        } else {
                                                          // Error
                                                          final message =
                                                              joinResponse[
                                                                      'data']
                                                                  ['message'];
                                                          // ignore: use_build_context_synchronously
                                                          popupService
                                                              .showErrorPopup(
                                                                  context,
                                                                  "Join Request Failed",
                                                                  message,
                                                                  () {});
                                                        }
                                                      }
                                                    } else if (!isJoinedGroup &&
                                                        targetGroupID ==
                                                            filteredGroupData[
                                                                index]['id']) {
                                                      // Resident has a pending join request
                                                      final joinResponse =
                                                          await apiService
                                                              .deleteJoinGroupRequestAPI({
                                                        "token": authService
                                                            .getAuthToken()
                                                      });
                                                      if (joinResponse !=
                                                          null) {
                                                        final status =
                                                            joinResponse[
                                                                'status'];
                                                        if (status > 0) {
                                                          // Success
                                                          final message =
                                                              joinResponse[
                                                                      'data']
                                                                  ['message'];
                                                          // ignore: use_build_context_synchronously
                                                          popupService
                                                              .showSuccessPopup(
                                                                  context,
                                                                  "Delete Request Success",
                                                                  message, () {
                                                            getData();
                                                          });
                                                        } else {
                                                          // Error
                                                          final message =
                                                              joinResponse[
                                                                      'data']
                                                                  ['message'];
                                                          // ignore: use_build_context_synchronously
                                                          popupService
                                                              .showErrorPopup(
                                                                  context,
                                                                  "Delete Request Failed",
                                                                  message,
                                                                  () {});
                                                        }
                                                      }
                                                    } else if (isJoinedGroup &&
                                                        targetGroupID ==
                                                            filteredGroupData[
                                                                index]['id']) {
                                                      // Resident has already joined a group
                                                      final joinResponse =
                                                          await apiService
                                                              .leaveGroupAPI({
                                                        "token": authService
                                                            .getAuthToken()
                                                      });
                                                      if (joinResponse !=
                                                          null) {
                                                        final status =
                                                            joinResponse[
                                                                'status'];
                                                        if (status > 0) {
                                                          // Success
                                                          final message =
                                                              joinResponse[
                                                                      'data']
                                                                  ['message'];
                                                          // ignore: use_build_context_synchronously
                                                          popupService
                                                              .showSuccessPopup(
                                                                  context,
                                                                  "Leave Group Success",
                                                                  message, () {
                                                            getData();
                                                          });
                                                        } else {
                                                          // Error
                                                          final message =
                                                              joinResponse[
                                                                      'data']
                                                                  ['message'];
                                                          // ignore: use_build_context_synchronously
                                                          popupService
                                                              .showErrorPopup(
                                                                  context,
                                                                  "Leave Group Failed",
                                                                  message,
                                                                  () {});
                                                        }
                                                      }
                                                    }
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          isAvailableGroupList
                                                              ? MaterialStateProperty.all<Color>(
                                                                  settings
                                                                      .joinGroupBgColor2)
                                                              : isJoinedGroup &&
                                                                      targetGroupID ==
                                                                          filteredGroupData[index][
                                                                              'id']
                                                                  ? MaterialStateProperty.all<Color>(
                                                                      settings
                                                                          .joinGroupBgColor3)
                                                                  : !isJoinedGroup &&
                                                                          targetGroupID ==
                                                                              filteredGroupData[index][
                                                                                  'id']
                                                                      ? MaterialStateProperty.all<Color>(settings
                                                                          .joinGroupBgColor4)
                                                                      : MaterialStateProperty.all<Color>(settings
                                                                          .joinGroupBgColor3),
                                                      padding: MaterialStateProperty.all<EdgeInsets>(
                                                          const EdgeInsets.fromLTRB(
                                                              25, 10, 25, 10))),
                                                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                    Icon(
                                                        isAvailableGroupList
                                                            ? Icons.group_add
                                                            : isJoinedGroup &&
                                                                    targetGroupID ==
                                                                        filteredGroupData[index]
                                                                            [
                                                                            'id']
                                                                ? Icons.logout
                                                                : !isJoinedGroup &&
                                                                        targetGroupID ==
                                                                            filteredGroupData[index][
                                                                                'id']
                                                                    ? Icons
                                                                        .cancel
                                                                    : Icons
                                                                        .not_interested,
                                                        color: settings
                                                            .joinGroupTextFieldIconColor,
                                                        size: 16.0),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                        isAvailableGroupList
                                                            ? 'Join'
                                                            : isJoinedGroup &&
                                                                    targetGroupID ==
                                                                        filteredGroupData[index]
                                                                            [
                                                                            'id']
                                                                ? "Leave"
                                                                : !isJoinedGroup &&
                                                                        targetGroupID ==
                                                                            filteredGroupData[index][
                                                                                'id']
                                                                    ? "Cancel"
                                                                    : '',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontFamily:
                                                                "OpenSans",
                                                            color: settings
                                                                .joinGroupTextFieldTextColor)),
                                                  ])),
                                              const SizedBox(height: 10.0),
                                            ],
                                          ),
                                        )),
                                  );
                                })
                            : SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: FractionallySizedBox(
                                    widthFactor: 1.0,
                                    child: Center(
                                        child: Text(
                                            "The Neighborhood Group List is Empty!",
                                            style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                color:
                                                    settings.joinGroupBgColor,
                                                fontSize: 14,
                                                fontWeight:
                                                    FontWeight.w600)))))),
                    isAvailableGroupList
                        ? Positioned(
                            bottom: 16.0,
                            right: 16.0,
                            child: FloatingActionButton(
                              backgroundColor: settings.bottomNavBarBgColor,
                              onPressed: () {
                                // Navigate to create neighborhood group screen
                                Navigator.pushNamed(context, '/creategroup')
                                    .then((_) {
                                  getData();
                                });
                              },
                              child: Icon(Icons.group_add,
                                  color: settings.bottomNavBarTextColor),
                            ),
                          )
                        : isJoinedGroup
                            ? Positioned(
                                bottom: 16.0,
                                right: 16.0,
                                child: FloatingActionButton(
                                  backgroundColor: settings.bottomNavBarBgColor,
                                  onPressed: () {
                                    // Navigate to manage neighborhood group screen
                                    Navigator.pushNamed(context, '/managegroup')
                                        .then((_) {
                                      getData();
                                    });
                                  },
                                  child: Icon(Icons.manage_accounts,
                                      color: settings.bottomNavBarTextColor),
                                ),
                              )
                            : Container()
                  ]);
                })));
  }
}
