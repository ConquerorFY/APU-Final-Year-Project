import 'package:etaman_frontend/services/api.dart';
import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/components.dart';
import 'package:etaman_frontend/services/logging.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:etaman_frontend/services/tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding_resolver/geocoding_resolver.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

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
  dynamic currentUserLocation;
  List<double> otherGroupLatitudes = [];
  List<double> otherGroupLongtitudes = [];
  List<String> otherGroupNames = [];
  List<int> otherGroupID = [];

  @override
  void initState() {
    super.initState();
    getAllGroupData();
  }

  Future<void> getAllGroupData() async {
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
          setState(() {
            otherGroupID.add(group['id']);
          });
        }
      });
      getCurrentUserLocation();
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

  dynamic getCurrentUserLocation() async {
    try {
      // Test if location services are enabled
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (!isLocationServiceEnabled) {
        // ignore: use_build_context_synchronously
        popupService.showErrorPopup(
            context, "Location Error", "Your location service is not opened!",
            () {
          Navigator.pop(context);
        });
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          // ignore: use_build_context_synchronously
          popupService.showErrorPopup(context, "Location Error",
              "Your location permission is denied forever!", () {
            Navigator.pop(context);
          });
          return;
        }
        if (permission == LocationPermission.denied) {
          // ignore: use_build_context_synchronously
          popupService.showErrorPopup(
              context, "Location Error", "Your location permission is denied!",
              () {
            Navigator.pop(context);
          });
          return;
        }
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentUserLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      logger.error(e);
    }
  }

  MarkerLayer generateLocationMarkers() {
    List<Marker> markersList = [];

    // Add current joined group location (if any)
    if (currentGroupName != null) {
      markersList.add(Marker(
          width: 40.0,
          height: 40.0,
          point: LatLng(currentGroupLatitude, currentGroupLongtitude),
          builder: (ctx) => InteractiveTooltip(
              message: currentGroupName,
              onTap: () {
                // Navigate to home page
                Navigator.pushNamed(ctx, '/home');
              },
              child: Icon(Icons.location_on,
                  color: settings.mapPrimaryMarkerColor))));
    }

    // Add other group location
    for (int i = 0; i < otherGroupLatitudes.length; i++) {
      if (otherGroupLatitudes[i] != currentGroupLatitude &&
          otherGroupLongtitudes[i] != currentGroupLongtitude) {
        markersList.add(Marker(
            width: 40.0,
            height: 40.0,
            point: LatLng(otherGroupLatitudes[i], otherGroupLongtitudes[i]),
            builder: (ctx) => InteractiveTooltip(
                message: otherGroupNames[i],
                height: 35.0,
                onTap: () {
                  // Navigate to view other group posts screen
                  Navigator.pushNamed(ctx, '/viewOtherGroupPost', arguments: {
                    'groupID': otherGroupID[i],
                    'groupName': otherGroupNames[i]
                  });
                },
                child: Icon(Icons.location_on,
                    color: settings.mapSecondaryMarkerColor))));
      }
    }

    // Add user current location
    markersList.add(Marker(
      width: 40.0,
      height: 40.0,
      point: currentUserLocation,
      builder: (ctx) => InteractiveTooltip(
          message: "You",
          height: 35.0,
          onTap: () {},
          child:
              Icon(Icons.my_location, color: settings.mapTertiaryMarkerColor)),
    ));

    return MarkerLayer(
      markers: markersList,
    );
  }

  void resetData() {
    setState(() {
      groupData = null;
      currentGroupID = null;
      currentGroupName = null;
      currentGroupLatitude = null;
      currentGroupLongtitude = null;
      currentUserLocation = null;
      otherGroupLatitudes = [];
      otherGroupLongtitudes = [];
      otherGroupNames = [];
      otherGroupID = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return currentGroupLatitude != null &&
            currentGroupLongtitude != null &&
            currentUserLocation != null
        ? Scaffold(
            appBar: TopAppBar(isImplyLeading: true),
            body: Stack(children: [
              FlutterMap(
                options: MapOptions(
                  center: currentUserLocation, // Center Coordinates
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
                        resetData();
                        getAllGroupData()
                            .then((_) => generateLocationMarkers());
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
        : Loading();
  }
}
