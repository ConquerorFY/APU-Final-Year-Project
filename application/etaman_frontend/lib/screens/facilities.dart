import 'package:etaman_frontend/services/api.dart';
import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/components.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FacilitiesContainer extends StatelessWidget {
  FacilitiesContainer({super.key});

  ApiService apiService = ApiService();
  PopupService popupService = PopupService();
  AuthService authService = AuthService();
  Settings settings = Settings();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: FacilitiesTopAppBar(isImplyLeading: false),
        body: Stack(children: [
          Builder(builder: (BuildContext innerContext) {
            return GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! < 0) {
                    Scaffold.of(innerContext).openDrawer();
                  }
                },
                child: const TabBarView(
                  children: [Facilities(), BookedFacilities()],
                ));
          }),
        ]),
        drawer: const LeftDrawer(),
        bottomNavigationBar: BottomNavBar(selectedIndex: 2),
      ),
    );
  }
}

class BookedFacilities extends StatefulWidget {
  const BookedFacilities({super.key});

  @override
  BookedFacilitiesState createState() => BookedFacilitiesState();
}

class BookedFacilitiesState extends State<BookedFacilities> {
  ApiService apiService = ApiService();
  PopupService popupService = PopupService();
  AuthService authService = AuthService();
  Settings settings = Settings();

  dynamic bookedFacilitiesData;
  dynamic residentID;
  dynamic groupID;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final residentResponse = await apiService
        .getResidentDataAPI({"token": authService.getAuthToken()});
    if (residentResponse != null) {
      final status = residentResponse['status'];
      if (status > 0) {
        // Success
        setState(() {
          residentID = residentResponse['data']['list']['id'];
          groupID = residentResponse['data']['list']['groupID'];
        });
        // Get All Neighborhood Facilities
        final facilitiesResponse =
            await apiService.getGroupFacilities({'groupID': groupID});
        if (facilitiesResponse != null) {
          final status = facilitiesResponse['status'];
          if (status > 0) {
            // Succes
            // Filter out facilities that are being booked by resident
            setState(() {
              bookedFacilitiesData = facilitiesResponse['data']['list']
                  .where((facility) => facility['holder'] == residentID)
                  .toList();
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bookedFacilitiesData.length > 0
          ? ListView.builder(
              itemCount: bookedFacilitiesData.length,
              itemBuilder: (context, index) {
                final facility = bookedFacilitiesData[index];
                return Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.bookmark,
                      color: settings.facilitiesIconColor,
                    ),
                    title: Text(facility['name'],
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            color: settings.facilitiesTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
                    subtitle: Text(facility['description'],
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            color: settings.facilitiesTextColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500)),
                    trailing: ElevatedButton(
                      onPressed: () async {
                        // Implement functionality for returning facility
                        Map<String, dynamic> returnData = {
                          "token": authService.getAuthToken(),
                          "facilitiesID": facility['id']
                        };
                        final returnResponse = await apiService
                            .returnGroupFacilitiesAPI(returnData);
                        if (returnResponse != null) {
                          final status = returnResponse['status'];
                          if (status > 0) {
                            // Success
                            final message = returnResponse['data']['message'];
                            // ignore: use_build_context_synchronously
                            popupService.showSuccessPopup(
                                context, "Return Success", message, () {
                              getData();
                            });
                          } else {
                            // Error
                            final message = returnResponse['data']['message'];
                            // ignore: use_build_context_synchronously
                            popupService.showErrorPopup(
                                context, "Return Failed", message, () {});
                          }
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              settings.facilitiesButtonColor)),
                      child: Text('Return',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              color: settings.facilitiesText2Color,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text("No booked facilities found!",
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      color: settings.facilitiesTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w700))),
    );
  }
}

class Facilities extends StatefulWidget {
  const Facilities({super.key});

  @override
  FacilitiesState createState() => FacilitiesState();
}

class FacilitiesState extends State<Facilities> {
  ApiService apiService = ApiService();
  PopupService popupService = PopupService();
  AuthService authService = AuthService();
  Settings settings = Settings();

  dynamic residentData;
  dynamic facilitiesData;
  dynamic allResidentsData;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final residentResponse = await apiService
        .getResidentDataAPI({"token": authService.getAuthToken()});
    if (residentResponse != null) {
      final status = residentResponse['status'];
      if (status > 0) {
        // Success
        setState(() {
          residentData = residentResponse['data']['list'];
        });
        getAllResidentData();
      }
    }
  }

  void getAllResidentData() async {
    final residentsResponse = await apiService
        .getAllNeighborhoodResidentsAPI({"token": authService.getAuthToken()});
    if (residentsResponse != null) {
      final status = residentsResponse['status'];
      if (status > 0) {
        // Success
        setState(() {
          allResidentsData = residentsResponse['data']['list'];
        });
        getFacilitiesData();
      }
    }
  }

  void getFacilitiesData() async {
    // Get Resident Data
    final residentResponse = await apiService
        .getResidentDataAPI({"token": authService.getAuthToken()});
    if (residentResponse != null) {
      final residentStatus = residentResponse['status'];
      if (residentStatus > 0) {
        // Success
        final groupID = residentResponse['data']['list']['groupID'];
        // Get Facilities Data
        final facilitiesResponse =
            await apiService.getGroupFacilities({"groupID": groupID});
        if (facilitiesResponse != null) {
          final facilitiesStatus = facilitiesResponse['status'];
          if (facilitiesStatus > 0) {
            // Success
            setState(() {
              facilitiesData = facilitiesResponse['data']['list'];
              for (dynamic facility in facilitiesData) {
                final filteredResident = allResidentsData.firstWhere(
                    (resident) => resident['id'] == facility['holder'],
                    orElse: () => null);
                facility['holderUsername'] = filteredResident != null
                    ? filteredResident['username']
                    : null;
              }
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      facilitiesData.length > 0
          ? ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: facilitiesData.length,
              itemBuilder: (context, index) {
                dynamic facility = facilitiesData[index];
                return FacilityCard(
                  id: facility['id'],
                  name: facility['name'],
                  description: facility['description'],
                  status: facility['status'],
                  holder: facility['holderUsername'],
                  residentUsername: residentData['username'],
                  isLeader: residentData['isLeader'],
                  updateParent: getData,
                );
              },
            )
          : Center(
              child: Text("No facilities found!",
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      color: settings.facilitiesTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w700))),
      Positioned(
        bottom: 16.0,
        right: 16.0,
        child: FloatingActionButton(
          backgroundColor: settings.bottomNavBarBgColor,
          onPressed: () {
            // Navigate to register facilities screen
            Navigator.pushNamed(context, '/registerfacilities').then((_) {
              getData();
            });
          },
          child: Icon(Icons.add, color: settings.bottomNavBarTextColor),
        ),
      ),
    ]));
  }
}

// ignore: must_be_immutable
class FacilityCard extends StatelessWidget {
  ApiService apiService = ApiService();
  PopupService popupService = PopupService();
  AuthService authService = AuthService();
  Settings settings = Settings();

  final int id;
  final String name;
  final String description;
  final String status;
  final String? holder;
  final String residentUsername;
  final bool isLeader;
  final VoidCallback updateParent;

  FacilityCard(
      {super.key,
      required this.id,
      required this.name,
      required this.description,
      required this.status,
      required this.holder,
      required this.residentUsername,
      required this.isLeader,
      required this.updateParent});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.star, color: settings.facilitiesIconColor),
            title: Text(name,
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: settings.facilitiesTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w900)),
            subtitle: Text(description,
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: settings.facilitiesTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
            trailing: status == 'Available'
                ? Icon(Icons.check_circle, color: settings.facilitiesIconColor)
                : status == 'Occupied'
                    ? Tooltip(
                        message:
                            "Occupied By: ${holder == residentUsername ? 'You' : holder}",
                        padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: settings.facilitiesTooltipBgColor),
                        textStyle: TextStyle(
                            fontFamily: 'OpenSans',
                            color: settings.facilitiesIconColor3,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                        child: Icon(Icons.cancel,
                            color: settings.facilitiesIconColor2))
                    : Container(),
          ),
          ButtonBar(
            children: [
              status == 'Available'
                  ? ElevatedButton(
                      onPressed: () async {
                        // Implement functionality for booking facility
                        Map<String, dynamic> bookData = {
                          "token": authService.getAuthToken(),
                          "facilitiesID": id
                        };
                        final bookResponse =
                            await apiService.bookGroupFacilitiesAPI(bookData);
                        if (bookResponse != null) {
                          final status = bookResponse['status'];
                          if (status > 0) {
                            // Success
                            final message = bookResponse['data']['message'];
                            // ignore: use_build_context_synchronously
                            popupService.showSuccessPopup(
                                context, "Book Success", message, () {
                              updateParent();
                            });
                          } else {
                            // Error
                            final message = bookResponse['data']['message'];
                            // ignore: use_build_context_synchronously
                            popupService.showErrorPopup(
                                context, "Book Failed", message, () {});
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            settings.facilitiesButtonColor),
                      ),
                      child: Text('Book',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              color: settings.facilitiesIconColor3,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    )
                  : const SizedBox.shrink(),
              status == 'Occupied' && holder == residentUsername
                  ? ElevatedButton(
                      onPressed: () async {
                        // Implement functionality for returning facility
                        Map<String, dynamic> returnData = {
                          "token": authService.getAuthToken(),
                          "facilitiesID": id
                        };
                        final returnResponse = await apiService
                            .returnGroupFacilitiesAPI(returnData);
                        if (returnResponse != null) {
                          final status = returnResponse['status'];
                          if (status > 0) {
                            // Success
                            final message = returnResponse['data']['message'];
                            // ignore: use_build_context_synchronously
                            popupService.showSuccessPopup(
                                context, "Return Success", message, () {
                              updateParent();
                            });
                          } else {
                            // Error
                            final message = returnResponse['data']['message'];
                            // ignore: use_build_context_synchronously
                            popupService.showErrorPopup(
                                context, "Return Failed", message, () {});
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            settings.facilitiesButtonColor),
                      ),
                      child: Text('Return',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              color: settings.facilitiesIconColor3,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    )
                  : const SizedBox.shrink(),
              isLeader
                  ? ElevatedButton(
                      onPressed: () {
                        // Implement functionality for editing facility
                        Navigator.pushNamed(context, '/editfacilities',
                            arguments: {
                              'facilitiesID': id,
                              'facilitiesName': name,
                              'facilitiesDescription': description
                            }).then((_) {
                          updateParent();
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            settings.facilitiesButtonColor3),
                      ),
                      child: Text('Edit',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              color: settings.facilitiesIconColor3,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    )
                  : const SizedBox.shrink(),
              isLeader
                  ? ElevatedButton(
                      onPressed: () async {
                        // Implement functionality for deleting facility
                        Map<String, dynamic> deleteData = {
                          "token": authService.getAuthToken(),
                          "facilitiesID": id
                        };
                        final deleteResponse = await apiService
                            .deleteGroupFacilitiesAPI(deleteData);
                        if (deleteResponse != null) {
                          final status = deleteResponse['status'];
                          if (status > 0) {
                            // Success
                            final message = deleteResponse['data']['message'];
                            // ignore: use_build_context_synchronously
                            popupService.showSuccessPopup(
                                context, "Delete Success", message, () {
                              updateParent();
                            });
                          } else {
                            // Error
                            final message = deleteResponse['data']['message'];
                            // ignore: use_build_context_synchronously
                            popupService.showErrorPopup(
                                context, "Delete Failed", message, () {});
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            settings.facilitiesButtonColor2),
                      ),
                      child: Text('Delete',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              color: settings.facilitiesIconColor3,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
