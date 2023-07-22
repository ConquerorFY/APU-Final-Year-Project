import 'package:etaman_frontend/services/api.dart';
import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/components.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';

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
        appBar: TopAppBar(isImplyLeading: false),
        body: Stack(children: [
          Builder(builder: (BuildContext innerContext) {
            return GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! < 0) {
                    Scaffold.of(innerContext).openDrawer();
                  }
                },
                child: ListView.builder(
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
                ));
          }),
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
        ]),
        drawer: const LeftDrawer(),
        bottomNavigationBar: BottomNavBar(selectedIndex: 2));
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
                      onPressed: () {
                        // Implement functionality for booking facility
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
                  : Container(),
              status == 'Occupied' && holder == residentUsername
                  ? ElevatedButton(
                      onPressed: () {
                        // Implement functionality for returning facility
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
                  : Container(),
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
                  : Container(),
              isLeader
                  ? ElevatedButton(
                      onPressed: () {
                        // Implement functionality for deleting facility
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
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
