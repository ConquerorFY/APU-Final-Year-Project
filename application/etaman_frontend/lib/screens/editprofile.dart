import 'dart:io';

import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:etaman_frontend/services/validator.dart';
import 'package:flutter/material.dart';
import 'package:etaman_frontend/services/api.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState<String>> _nameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _stateKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _cityKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _postcodeKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _streetKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _contactKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _usernameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();

  dynamic profileData;
  File? selectedImage;

  Validator validator = Validator();
  ApiService apiService = ApiService();
  PopupService popupService = PopupService();
  AuthService authService = AuthService();
  Settings settings = Settings();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    Map<String, dynamic> tokenData = {"token": authService.getAuthToken()};
    final responseData = await apiService.getResidentDataAPI(tokenData);
    if (responseData != null) {
      final status = responseData['status'];
      if (status > 0) {
        // Success
        setState(() {
          profileData = {
            'name': responseData['data']['list']['name'],
            'email': responseData['data']['list']['email'],
            'state': responseData['data']['list']['state'],
            'city': responseData['data']['list']['city'],
            'postcode': responseData['data']['list']['postcode'].toString(),
            'street': responseData['data']['list']['street'],
            'contact': responseData['data']['list']['contact'],
            'username': responseData['data']['list']['username'],
            'password': '12345678'
          };
        });
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      // Only valid for window / applications
      // If for website, pickedImage.path returns a Blob URL
      // Need to convert from Blob URL -> http.File -> io.File
      setState(() {
        selectedImage = File(pickedImage.path);
      });

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: settings.editProfileBgColor,
          title: Text('Edit Profile',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  fontFamily: "OpenSans",
                  color: settings.editProfileTextFieldText2Color)),
          shadowColor: settings.editProfileTextFieldShadowColor,
          elevation: 5.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      key: _nameKey,
                      initialValue: profileData['name'],
                      validator: (value) {
                        return validator.validateName(value);
                      },
                      onChanged: (value) {
                        _nameKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.editProfileTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.editProfileTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.editProfileTextFieldTextColor),
                        labelText: 'Name',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth +
                                        1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _emailKey,
                      initialValue: profileData['email'],
                      validator: (value) {
                        return validator.validateEmail(value);
                      },
                      onChanged: (value) {
                        _emailKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.editProfileTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.editProfileTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.editProfileTextFieldTextColor),
                        labelText: 'Email',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth +
                                        1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _stateKey,
                      initialValue: profileData['state'],
                      validator: (value) {
                        return validator.validateState(value);
                      },
                      onChanged: (value) {
                        _stateKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.editProfileTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.editProfileTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.editProfileTextFieldTextColor),
                        labelText: 'State',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth +
                                        1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _cityKey,
                      initialValue: profileData['city'],
                      validator: (value) {
                        return validator.validateCity(value);
                      },
                      onChanged: (value) {
                        _cityKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.editProfileTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.editProfileTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.editProfileTextFieldTextColor),
                        labelText: 'City',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth +
                                        1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _postcodeKey,
                      initialValue: profileData['postcode'],
                      validator: (value) {
                        return validator.validatePostcode(value);
                      },
                      onChanged: (value) {
                        _postcodeKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.editProfileTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.editProfileTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.editProfileTextFieldTextColor),
                        labelText: 'Postcode',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth +
                                        1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _streetKey,
                      initialValue: profileData['street'],
                      validator: (value) {
                        return validator.validateStreet(value);
                      },
                      onChanged: (value) {
                        _streetKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.editProfileTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.editProfileTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.editProfileTextFieldTextColor),
                        labelText: 'Street',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth +
                                        1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _contactKey,
                      initialValue: profileData['contact'],
                      validator: (value) {
                        return validator.validateContact(value);
                      },
                      onChanged: (value) {
                        _contactKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.editProfileTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.editProfileTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.editProfileTextFieldTextColor),
                        labelText: 'Contact Number',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth +
                                        1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _usernameKey,
                      initialValue: profileData['username'],
                      validator: (value) {
                        return validator.validateUsername(value);
                      },
                      onChanged: (value) {
                        _usernameKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.editProfileTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.editProfileTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.editProfileTextFieldTextColor),
                        labelText: 'Username',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth +
                                        1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _passwordKey,
                      initialValue: profileData['password'],
                      validator: (value) {
                        return validator.validatePassword(value);
                      },
                      onChanged: (value) {
                        _passwordKey.currentState!.validate();
                      },
                      obscureText: true,
                      style: TextStyle(
                          color: settings.editProfileTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.editProfileTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.editProfileTextFieldTextColor),
                        labelText: 'Password',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editProfileTextFieldBorderColor,
                                width:
                                    settings.editProfileTextFieldBorderWidth +
                                        1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ]),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  selectedImage != null
                      ? Icon(
                          Icons.done,
                          color: settings.editProfileBgColor,
                          size: 40.0,
                        )
                      : Icon(Icons.cancel,
                          color: settings.editProfileBgColor2, size: 40.0),
                  const SizedBox(width: 20.0),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            settings.editProfileTextFieldTextColor),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.fromLTRB(50, 20, 50, 20))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo,
                              color: settings.editProfileTextFieldIconColor),
                          const SizedBox(width: 8),
                          Text('Add Image',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "OpenSans",
                                  color:
                                      settings.editProfileTextFieldText2Color)),
                        ]),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            titlePadding:
                                const EdgeInsets.fromLTRB(20.0, 15.0, 0, 50.0),
                            title: Text('Select Image Source',
                                style: TextStyle(
                                    color:
                                        settings.editProfileTextFieldTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'OpenSans')),
                            contentPadding:
                                const EdgeInsets.fromLTRB(0, 0, 10.0, 20.0),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    _pickImage(ImageSource.gallery),
                                child: Text('Gallery',
                                    style: TextStyle(
                                        color: settings
                                            .editProfileTextFieldTextColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'OpenSans')),
                              ),
                              TextButton(
                                onPressed: () => _pickImage(ImageSource.camera),
                                child: Text('Camera',
                                    style: TextStyle(
                                        color: settings
                                            .editProfileTextFieldTextColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'OpenSans')),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ]),
                const SizedBox(height: 20.0),
                ElevatedButton(
                    onPressed: () async {
                      // Handle edit profile process
                      Map<String, dynamic> userData = {
                        "name": _nameKey.currentState?.value,
                        "email": _emailKey.currentState?.value,
                        "contact": _contactKey.currentState?.value,
                        "state": _stateKey.currentState?.value,
                        "city": _cityKey.currentState?.value,
                        "street": _streetKey.currentState?.value,
                        "postcode": _postcodeKey.currentState?.value,
                        "username": _usernameKey.currentState?.value,
                        "password": _passwordKey.currentState?.value,
                        "image": selectedImage
                      };
                      if (!(_nameKey.currentState!.validate() &&
                          _emailKey.currentState!.validate() &&
                          _stateKey.currentState!.validate() &&
                          _cityKey.currentState!.validate() &&
                          _postcodeKey.currentState!.validate() &&
                          _streetKey.currentState!.validate() &&
                          _contactKey.currentState!.validate() &&
                          _usernameKey.currentState!.validate() &&
                          _passwordKey.currentState!.validate())) {
                        popupService.showErrorPopup(
                            context,
                            "Validation Message",
                            "Please ensure all fields are valid before submitting!",
                            () {});
                      } else {
                        // Filter out attributes that are not changed / updated by user
                        userData.removeWhere(
                            (key, value) => profileData[key] == value);
                        // Add token into userData
                        userData['token'] = authService.getAuthToken();
                        final response =
                            await apiService.editAccountAPI(userData);
                        if (response != null) {
                          final status = response["status"];
                          final message = response["data"]["message"];
                          if (status > 0) {
                            // Success message
                            // ignore: use_build_context_synchronously
                            popupService.showSuccessPopup(
                                context, "Edit Profile Success", message, () {
                              setState(() {
                                selectedImage = null;
                              });
                              getData();
                            });
                          } else {
                            // Error message
                            // ignore: use_build_context_synchronously
                            popupService.showErrorPopup(
                                context, "Edit Profile Error", message, () {});
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            settings.editProfileTextFieldTextColor),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.fromLTRB(50, 20, 50, 20))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit,
                              color: settings.editProfileTextFieldIconColor),
                          const SizedBox(width: 8),
                          Text('Edit',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "OpenSans",
                                  color:
                                      settings.editProfileTextFieldText2Color)),
                        ])),
              ],
            ),
          ),
        ));
  }
}
