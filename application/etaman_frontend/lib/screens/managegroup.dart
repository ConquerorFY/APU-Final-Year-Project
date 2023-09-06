import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/components.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:etaman_frontend/services/validator.dart';
import 'package:flutter/material.dart';
import 'package:etaman_frontend/services/api.dart';

class ManageGroup extends StatefulWidget {
  const ManageGroup({super.key});

  @override
  ManageGroupState createState() => ManageGroupState();
}

class ManageGroupState extends State<ManageGroup> {
  dynamic residentData;
  dynamic groupData;
  dynamic joinRequestsData;
  bool isLeaderLoggedIn = false;

  Validator validator = Validator();
  ApiService apiService = ApiService();
  PopupService popupService = PopupService();
  AuthService authService = AuthService();
  Settings settings = Settings();

  @override
  void initState() {
    super.initState();
    getResidentData();
  }

  Future<void> getResidentData() async {
    final residentResponse = await apiService
        .getResidentDataAPI({"token": authService.getAuthToken()});
    if (residentResponse != null) {
      final status = residentResponse['status'];
      if (status > 0) {
        // Success
        setState(() {
          residentData = residentResponse['data']['list'];
        });
        getAllGroupResidents();
      }
    }
  }

  void getAllGroupResidents() async {
    final groupResponse = await apiService
        .getAllNeighborhoodResidentsAPI({"token": authService.getAuthToken()});
    if (groupResponse != null) {
      final status = groupResponse['status'];
      if (status > 0) {
        // Success
        setState(() {
          groupData = groupResponse['data']['list'];
        });
        getAllJoinRequests();
      }
    }
  }

  void getAllJoinRequests() async {
    final joinResponse =
        await apiService.getAllNeighborhoodGroupJoinRequestsAPI();
    if (joinResponse != null) {
      final status = joinResponse['status'];
      if (status > 0) {
        // Success
        setState(() {
          joinRequestsData = joinResponse['data']['list'];
        });
        checkWhetherLeaderLoggedIn();
      }
    }
  }

  void checkWhetherLeaderLoggedIn() async {
    final checkResponse = await apiService
        .getResidentDataAPI({"token": authService.getAuthToken()});
    if (checkResponse != null) {
      final status = checkResponse['status'];
      if (status > 0) {
        // Success
        setState(() {
          isLeaderLoggedIn = checkResponse['data']['list']['isLeader'];
        });
      }
    }
  }

  void handleJoinRequest(requestID, action) async {
    Map<String, dynamic> handleData = {"id": requestID, "action": action};
    final handleResponse =
        await apiService.handleNeighborhoodGroupJoinRequestAPI(handleData);
    if (handleResponse != null) {
      final status = handleResponse['status'];
      if (status > 0) {
        // Success
        final message = handleResponse['data']['message'];
        // ignore: use_build_context_synchronously
        popupService.showSuccessPopup(context, "Join Request Handled", message,
            () {
          getResidentData();
        });
      } else {
        // Error
        final message = handleResponse['data']['message'];
        // ignore: use_build_context_synchronously
        popupService.showErrorPopup(
            context, "Join Request Failed", message, () {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return joinRequestsData != null
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: settings.manageGroupBgColor,
              title: Text('Manage Group',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      fontFamily: "OpenSans",
                      color: settings.manageGroupText2Color)),
              shadowColor: settings.manageGroupShadowColor,
              elevation: 5.0,
            ),
            body: RefreshIndicator(
                color: settings.loadingBgColor,
                onRefresh: getResidentData,
                child: FutureBuilder(
                    future: Future.delayed(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      return SizedBox(
                        height: double.infinity,
                        child: Stack(children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  30.0, 20.0, 30.0, 20.0),
                              child: SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Center(
                                        child: Text(residentData['groupName'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                color: settings
                                                    .manageGroupTextColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900))),
                                    const SizedBox(height: 30.0),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Address",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                color: settings
                                                    .manageGroupTextColor,
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w600))),
                                    const SizedBox(height: 5.0),
                                    Wrap(
                                      spacing:
                                          8.0, // Spacing between children (horizontal)
                                      runSpacing:
                                          5.0, // Spacing between lines (vertical)
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "State: ${residentData['groupState']}",
                                                  style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      color: settings
                                                          .manageGroupTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w800)),
                                              const SizedBox(height: 5.0),
                                              Text(
                                                  "City: ${residentData['groupCity']}",
                                                  style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      color: settings
                                                          .manageGroupTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w800)),
                                            ]),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Postcode: ${residentData['groupPostcode']}",
                                                  style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      color: settings
                                                          .manageGroupTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w800)),
                                              const SizedBox(height: 5.0),
                                              Text(
                                                  "Street: ${residentData['groupStreet']}",
                                                  style: TextStyle(
                                                    fontFamily: 'OpenSans',
                                                    color: settings
                                                        .manageGroupTextColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                  softWrap: true),
                                            ])
                                      ],
                                    ),
                                    const SizedBox(height: 30.0),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Rules",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                color: settings
                                                    .manageGroupTextColor,
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w600))),
                                    const SizedBox(height: 5.0),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(residentData['groupRule'],
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                color: settings
                                                    .manageGroupTextColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w800))),
                                    const SizedBox(height: 30.0),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Group Members",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                color: settings
                                                    .manageGroupTextColor,
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w600))),
                                    const SizedBox(height: 5.0),
                                    SingleChildScrollView(
                                        child: SizedBox(
                                      height: 150,
                                      child: ListView.builder(
                                        itemCount: groupData.length,
                                        itemBuilder: (context, index) {
                                          final resident = groupData[index];
                                          return ListTile(
                                              isThreeLine: true,
                                              leading: Text("${index + 1}.",
                                                  style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      color: settings
                                                          .manageGroupTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              title: Text(resident['username'],
                                                  style: TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      color: settings
                                                          .manageGroupTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w900)),
                                              subtitle: Column(children: [
                                                Text(resident['email'],
                                                    style: TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        color: settings
                                                            .manageGroupTextColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                const SizedBox(height: 5.0),
                                                Text(resident['contact'],
                                                    style: TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        color: settings
                                                            .manageGroupTextColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ]),
                                              trailing: resident['isLeader']
                                                  ? SizedBox(
                                                      width: 90.0,
                                                      child: Text('Leader',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'OpenSans',
                                                              color: settings
                                                                  .manageGroupTextColor,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)))
                                                  : isLeaderLoggedIn
                                                      ? SingleChildScrollView(
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                              Text('Member',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'OpenSans',
                                                                      color: settings
                                                                          .manageGroupTextColor,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                              const SizedBox(
                                                                  height: 10.0),
                                                              Column(children: [
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () async {
                                                                    // Promote resident to leader
                                                                    Map<String,
                                                                            dynamic>
                                                                        changeData =
                                                                        {
                                                                      "token":
                                                                          authService
                                                                              .getAuthToken(),
                                                                      "targetID":
                                                                          resident[
                                                                              'id']
                                                                    };
                                                                    final changeResponse =
                                                                        await apiService
                                                                            .changeResidentLeaderAPI(changeData);
                                                                    if (changeResponse !=
                                                                        null) {
                                                                      final status =
                                                                          changeResponse[
                                                                              'status'];
                                                                      if (status >
                                                                          0) {
                                                                        // Success
                                                                        final message =
                                                                            changeResponse['data']['message'];
                                                                        // ignore: use_build_context_synchronously
                                                                        popupService.showSuccessPopup(
                                                                            context,
                                                                            "Change Leader Success",
                                                                            message,
                                                                            () {
                                                                          getResidentData();
                                                                        });
                                                                      } else {
                                                                        // Error
                                                                        final message =
                                                                            changeResponse['data']['message'];
                                                                        // ignore: use_build_context_synchronously
                                                                        popupService.showErrorPopup(
                                                                            context,
                                                                            "Change Leader Failed",
                                                                            message,
                                                                            () {});
                                                                      }
                                                                    }
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                      maximumSize: const Size
                                                                          .square(
                                                                          90.0),
                                                                      backgroundColor:
                                                                          settings
                                                                              .manageGroupButtonColor),
                                                                  child: Row(
                                                                      children: [
                                                                        Icon(
                                                                            Icons
                                                                                .upgrade,
                                                                            size:
                                                                                20.0,
                                                                            color:
                                                                                settings.manageGroupText2Color),
                                                                        const SizedBox(
                                                                            width:
                                                                                3.0),
                                                                        Text(
                                                                            "Promote",
                                                                            style: TextStyle(
                                                                                fontFamily: 'OpenSans',
                                                                                color: settings.manageGroupText2Color,
                                                                                fontSize: 8,
                                                                                fontWeight: FontWeight.w600))
                                                                      ]),
                                                                ),
                                                                const SizedBox(
                                                                    height:
                                                                        5.0),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () async {
                                                                    // Kick resident
                                                                    Map<String,
                                                                            dynamic>
                                                                        kickData =
                                                                        {
                                                                      "token":
                                                                          authService
                                                                              .getAuthToken(),
                                                                      "targetID":
                                                                          resident[
                                                                              'id']
                                                                    };
                                                                    final changeResponse =
                                                                        await apiService
                                                                            .kickResidentAPI(kickData);
                                                                    if (changeResponse !=
                                                                        null) {
                                                                      final status =
                                                                          changeResponse[
                                                                              'status'];
                                                                      if (status >
                                                                          0) {
                                                                        // Success
                                                                        final message =
                                                                            changeResponse['data']['message'];
                                                                        // ignore: use_build_context_synchronously
                                                                        popupService.showSuccessPopup(
                                                                            context,
                                                                            "Kick Resident Success",
                                                                            message,
                                                                            () {
                                                                          getResidentData();
                                                                        });
                                                                      } else {
                                                                        // Error
                                                                        final message =
                                                                            changeResponse['data']['message'];
                                                                        // ignore: use_build_context_synchronously
                                                                        popupService.showErrorPopup(
                                                                            context,
                                                                            "Kick Resident Failed",
                                                                            message,
                                                                            () {});
                                                                      }
                                                                    }
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                      maximumSize: const Size
                                                                          .square(
                                                                          90.0),
                                                                      backgroundColor:
                                                                          settings
                                                                              .manageGroupButtonColor2),
                                                                  child: Row(
                                                                      children: [
                                                                        Icon(
                                                                            Icons
                                                                                .delete,
                                                                            size:
                                                                                20.0,
                                                                            color:
                                                                                settings.manageGroupText2Color),
                                                                        const SizedBox(
                                                                            width:
                                                                                3.0),
                                                                        Text(
                                                                            "Kick",
                                                                            style: TextStyle(
                                                                                fontFamily: 'OpenSans',
                                                                                color: settings.manageGroupText2Color,
                                                                                fontSize: 8,
                                                                                fontWeight: FontWeight.w600))
                                                                      ]),
                                                                ),
                                                              ])
                                                            ]))
                                                      : SizedBox(
                                                          width: 90.0,
                                                          child: Text('Member',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'OpenSans',
                                                                  color: settings
                                                                      .manageGroupTextColor,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))));
                                        },
                                      ),
                                    )),
                                    const SizedBox(height: 30.0),
                                    if (isLeaderLoggedIn)
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Pending Join Requests",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontFamily: 'OpenSans',
                                                  color: settings
                                                      .manageGroupTextColor,
                                                  fontSize: 14,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontWeight:
                                                      FontWeight.w600))),
                                    if (isLeaderLoggedIn)
                                      const SizedBox(height: 5.0),
                                    if (isLeaderLoggedIn)
                                      SingleChildScrollView(
                                          child: SizedBox(
                                        height: 150,
                                        child: ListView.builder(
                                          itemCount: joinRequestsData.length,
                                          itemBuilder: (context, index) {
                                            final resident =
                                                joinRequestsData[index];
                                            return ListTile(
                                                isThreeLine: true,
                                                leading: Text("${index + 1}.",
                                                    style: TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        color: settings
                                                            .manageGroupTextColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                title: Text(
                                                    resident['residentName'],
                                                    style: TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        color: settings
                                                            .manageGroupTextColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w900)),
                                                subtitle: Column(children: [
                                                  Text(
                                                      resident['residentEmail'],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'OpenSans',
                                                          color: settings
                                                              .manageGroupTextColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  const SizedBox(height: 5.0),
                                                  Text(
                                                      resident[
                                                          'residentContact'],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'OpenSans',
                                                          color: settings
                                                              .manageGroupTextColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ]),
                                                trailing: SingleChildScrollView(
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                      Column(children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            // Approve Request
                                                            handleJoinRequest(
                                                                resident['id'],
                                                                "approve");
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  maximumSize:
                                                                      const Size
                                                                          .square(
                                                                          90.0),
                                                                  backgroundColor:
                                                                      settings
                                                                          .manageGroupButtonColor),
                                                          child: Row(children: [
                                                            Icon(Icons.done,
                                                                size: 20.0,
                                                                color: settings
                                                                    .manageGroupText2Color),
                                                            const SizedBox(
                                                                width: 3.0),
                                                            Text("Approve",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'OpenSans',
                                                                    color: settings
                                                                        .manageGroupText2Color,
                                                                    fontSize: 8,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600))
                                                          ]),
                                                        ),
                                                        const SizedBox(
                                                            height: 5.0),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            // Reject Request
                                                            handleJoinRequest(
                                                                resident['id'],
                                                                "reject");
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  maximumSize:
                                                                      const Size
                                                                          .square(
                                                                          90.0),
                                                                  backgroundColor:
                                                                      settings
                                                                          .manageGroupButtonColor2),
                                                          child: Row(children: [
                                                            Icon(
                                                                Icons
                                                                    .cancel_rounded,
                                                                size: 20.0,
                                                                color: settings
                                                                    .manageGroupText2Color),
                                                            const SizedBox(
                                                                width: 3.0),
                                                            Text("Reject",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'OpenSans',
                                                                    color: settings
                                                                        .manageGroupText2Color,
                                                                    fontSize: 8,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600))
                                                          ]),
                                                        ),
                                                      ])
                                                    ])));
                                          },
                                        ),
                                      )),
                                  ]))),
                          residentData['isLeader']
                              ? Positioned(
                                  bottom: 16.0,
                                  right: 16.0,
                                  child: FloatingActionButton(
                                    backgroundColor:
                                        settings.bottomNavBarBgColor,
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/editgroup')
                                          .then(
                                        (_) {
                                          getResidentData();
                                        },
                                      );
                                    },
                                    child: Icon(Icons.edit,
                                        color: settings.bottomNavBarTextColor),
                                  ),
                                )
                              : Container()
                        ]),
                      );
                    })))
        : Loading();
  }
}
