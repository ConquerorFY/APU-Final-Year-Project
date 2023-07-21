import 'package:etaman_frontend/services/api.dart';
import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  ApiService apiService = ApiService(); // API Service
  PopupService popupService = PopupService(); // Popup Service
  AuthService authService = AuthService(); // Auth Service
  Settings settings = Settings();

  dynamic residentData;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    Map<String, dynamic> tokenData = {"token": authService.getAuthToken()};
    final residentResponse = await apiService.getResidentDataAPI(tokenData);
    if (residentResponse != null) {
      final status = residentResponse['status'];
      if (status > 0) {
        // Success
        setState(() {
          residentData = {
            'image': residentResponse['data']['list']['image'],
            'name': residentResponse['data']['list']['name'],
            'email': residentResponse['data']['list']['email'],
            'contact': residentResponse['data']['list']['contact'],
            'state': residentResponse['data']['list']['state'],
            'city': residentResponse['data']['list']['city'],
            'street': residentResponse['data']['list']['street'],
            'postcode': residentResponse['data']['list']['postcode'],
            'username': residentResponse['data']['list']['username'],
            'groupName': residentResponse['data']['list']['groupName'],
            'isGroupLeader': residentResponse['data']['list']['isLeader']
          };
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Icon(Icons.person, color: settings.profileTopNavBarTextColor),
            const SizedBox(width: 15.0),
            const Text('Profile',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w900,
                )),
          ]),
          backgroundColor: settings.profileTopNavBarBgColor,
          foregroundColor: settings.profileTopNavBarTextColor,
        ),
        body: Stack(children: [
          SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16.0),
                CircleAvatar(
                  radius: 80.0,
                  backgroundImage: residentData['image'] != null
                      ? Image.network(
                          "${apiService.mediaUrl}${residentData['image']}",
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
                                    color: settings.profileTextColor));
                          },
                        ).image
                      : Image.asset('assets/avatar.png', width: double.infinity)
                          .image,
                ),
                const SizedBox(height: 16.0),
                Text(
                  residentData['username'],
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'OpenSans',
                      color: settings.profileTextColor),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Resident Account',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'OpenSans',
                    color: settings.profileTextColor,
                  ),
                ),
                const SizedBox(height: 16.0),
                ListTile(
                    leading:
                        Icon(Icons.person, color: settings.profileIconColor),
                    title: Text(residentData['name'],
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600,
                            color: settings.profileTextColor)),
                    subtitle: Text('Name',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w300,
                            color: settings.profileTextColor))),
                ListTile(
                    leading:
                        Icon(Icons.email, color: settings.profileIconColor),
                    title: Text(residentData['email'],
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600,
                            color: settings.profileTextColor)),
                    subtitle: Text('Email',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w300,
                            color: settings.profileTextColor))),
                ListTile(
                    leading:
                        Icon(Icons.phone, color: settings.profileIconColor),
                    title: Text(residentData['contact'],
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600,
                            color: settings.profileTextColor)),
                    subtitle: Text('Contact',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w300,
                            color: settings.profileTextColor))),
                ListTile(
                    leading:
                        Icon(Icons.place, color: settings.profileIconColor),
                    title: Text(residentData['state'],
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600,
                            color: settings.profileTextColor)),
                    subtitle: Text('State',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w300,
                            color: settings.profileTextColor))),
                ListTile(
                    leading:
                        Icon(Icons.place, color: settings.profileIconColor),
                    title: Text(residentData['city'],
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600,
                            color: settings.profileTextColor)),
                    subtitle: Text('City',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w300,
                            color: settings.profileTextColor))),
                ListTile(
                    leading:
                        Icon(Icons.place, color: settings.profileIconColor),
                    title: Text(residentData['street'],
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600,
                            color: settings.profileTextColor)),
                    subtitle: Text('Street',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w300,
                            color: settings.profileTextColor))),
                ListTile(
                    leading:
                        Icon(Icons.numbers, color: settings.profileIconColor),
                    title: Text(residentData['postcode'].toString(),
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600,
                            color: settings.profileTextColor)),
                    subtitle: Text('Postcode',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w300,
                            color: settings.profileTextColor))),
                ListTile(
                    leading:
                        Icon(Icons.person, color: settings.profileIconColor),
                    title: Text(residentData['username'],
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600,
                            color: settings.profileTextColor)),
                    subtitle: Text('Username',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w300,
                            color: settings.profileTextColor))),
                ListTile(
                    leading:
                        Icon(Icons.group, color: settings.profileIconColor),
                    title: Text(residentData['groupName'],
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600,
                            color: settings.profileTextColor)),
                    subtitle: Text('Group Name',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w300,
                            color: settings.profileTextColor))),
                ListTile(
                    leading:
                        Icon(Icons.group, color: settings.profileIconColor),
                    title: Text(residentData['isGroupLeader'] ? "Yes" : "No",
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600,
                            color: settings.profileTextColor)),
                    subtitle: Text('Is Group Leader',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w300,
                            color: settings.profileTextColor))),
              ],
            ),
          )),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              backgroundColor: settings.bottomNavBarBgColor,
              onPressed: () {
                // Navigate to edit resident account screen
                Navigator.pushNamed(context, '/editProfile').then((_) {
                  getData();
                });
              },
              child:
                  Icon(Icons.edit, color: settings.profileTopNavBarTextColor),
            ),
          )
        ]));
  }
}
