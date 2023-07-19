import 'package:etaman_frontend/services/api.dart';
import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/components.dart';
import 'package:etaman_frontend/services/logging.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding_resolver/geocoding_resolver.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  ApiService apiService = ApiService();
  PopupService popupService = PopupService();
  AuthService authService = AuthService();
  Settings settings = Settings();
  EtamanLogger logger = EtamanLogger();

  GeoCoder geoCoder = GeoCoder();
  dynamic groupData;
  dynamic currentGroupID;
  dynamic currentGroupName;
  dynamic currentGroupLatitude;
  dynamic currentGroupLongtitude;
  List<double> otherGroupLatitudes = [];
  List<double> otherGroupLongtitudes = [];
  List<String> otherGroupNames = [];

  @override
  void initState() {
    super.initState();
    getAllGroupData();
  }

  void getAllGroupData() async {
    // Get All Neighborhood Group Info
    final groupInfo = await apiService.getAllNeighborhoodGroupsAPI();
    if (groupInfo != null) {
      final groupStatus = groupInfo['status'];
      if (groupStatus > 0) {
        // Success
        setState(() {
          groupData = groupInfo['data']['list'];
        });

        getCurrentGroupLocation();
      }
    }
  }

  void getOtherGroupLocations() async {
    try {
      groupData.forEach((group) async {
        if (group["id"] != currentGroupID) {
          String addr =
              "${group['street']}, ${group['postcode']} ${group['city']}, ${group['state']}, Malaysia}";
          List<LookupAddress> addresses =
              await geoCoder.getAddressSuggestions(address: addr);
          setState(() {
            otherGroupLatitudes.add(double.parse(addresses.first.latitude));
          });
          setState(() {
            otherGroupLongtitudes.add(double.parse(addresses.first.longitude));
          });
          setState(() {
            otherGroupNames.add(group['name']);
          });
        }
      });
    } catch (e) {
      logger.error(e);
    }
  }

  void getCurrentGroupLocation() async {
    try {
      // Get Resident Info
      final residentInfo = await apiService
          .getResidentDataAPI({"token": authService.getAuthToken()});
      if (residentInfo != null) {
        final residentInfoStatus = residentInfo['status'];
        if (residentInfoStatus > 0) {
          final residentGroupID = residentInfo['data']['list']['groupID'];
          if (residentGroupID != null) {
            // Resident has joined a group
            groupData.forEach((group) async {
              if (group["id"] == residentGroupID) {
                String addr =
                    "${group['street']}, ${group['postcode']} ${group['city']}, ${group['state']}, Malaysia";
                List<LookupAddress> addresses =
                    await geoCoder.getAddressSuggestions(address: addr);
                setState(() {
                  currentGroupLatitude = double.parse(addresses.first.latitude);
                });
                setState(() {
                  currentGroupLongtitude =
                      double.parse(addresses.first.longitude);
                });
                setState(() {
                  currentGroupID = residentGroupID;
                });
                setState(() {
                  currentGroupName = group['name'];
                });
              }
            });
            getOtherGroupLocations();
          } else {
            // Resident has not joined any group
            setState(() {
              currentGroupLatitude = 4.2105;
            });
            setState(() {
              currentGroupLongtitude = 101.9758;
            });
            getOtherGroupLocations();
          }
        }
      }
    } catch (e) {
      logger.error(e);
    }
  }

  MarkerLayer generateLocationMarkers() {
    List<Marker> markersList = [];

    if (currentGroupName != null) {
      markersList.add(Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(currentGroupLatitude, currentGroupLongtitude),
        builder: (ctx) => Tooltip(
          waitDuration: Duration(seconds: settings.mapWaitDuration),
          showDuration: Duration(seconds: settings.mapShowDuration),
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
          textStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 10,
              color: settings.mapTooltipTextColor,
              fontWeight: FontWeight.bold),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: settings.mapTooltipBgColor),
          message: currentGroupName,
          child: Icon(Icons.location_on, color: settings.mapPrimaryMarkerColor),
        ),
      ));
    }

    for (int i = 0; i < otherGroupLatitudes.length; i++) {
      if (otherGroupLatitudes[i] != currentGroupLatitude &&
          otherGroupLongtitudes[i] != currentGroupLongtitude) {
        markersList.add(Marker(
          width: 40.0,
          height: 40.0,
          point: LatLng(otherGroupLatitudes[i], otherGroupLongtitudes[i]),
          builder: (ctx) => Tooltip(
            waitDuration: Duration(seconds: settings.mapWaitDuration),
            showDuration: Duration(seconds: settings.mapShowDuration),
            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
            height: 35,
            textStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 10,
                color: settings.mapTooltipTextColor,
                fontWeight: FontWeight.bold),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: settings.mapTooltipBgColor),
            message: otherGroupNames[i],
            child: Icon(Icons.location_on,
                color: settings.mapSecondaryMarkerColor),
          ),
        ));
      }
    }

    return MarkerLayer(
      markers: markersList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return currentGroupLatitude != null && currentGroupLongtitude != null
        ? Scaffold(
            appBar: TopAppBar(isImplyLeading: true),
            body: Stack(children: [
              FlutterMap(
                options: MapOptions(
                  center: LatLng(currentGroupLatitude,
                      currentGroupLongtitude), // Center Coordinates
                  zoom: 8, // Initial Zoom Level
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  generateLocationMarkers(),
                ],
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: FloatingActionButton(
                  backgroundColor: settings.bottomNavBarBgColor,
                  onPressed: () {
                    Navigator.pushNamed(context, '/joingroup').then(
                      (_) {
                        getAllGroupData();
                      },
                    );
                  },
                  child:
                      Icon(Icons.groups, color: settings.bottomNavBarTextColor),
                ),
              )
            ]),
            drawer: const LeftDrawer(),
            bottomNavigationBar: BottomNavBar(selectedIndex: 1))
        : Container();
  }
}