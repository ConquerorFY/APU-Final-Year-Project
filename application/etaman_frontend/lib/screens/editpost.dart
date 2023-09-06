import 'dart:io';

import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:etaman_frontend/services/utils.dart';
import 'package:etaman_frontend/services/validator.dart';
import 'package:flutter/material.dart';
import 'package:etaman_frontend/services/api.dart';
import 'package:image_picker/image_picker.dart';

class EditPost extends StatefulWidget {
  const EditPost({super.key});

  @override
  EditPostState createState() => EditPostState();
}

class EditPostState extends State<EditPost> {
  File? selectedImage;
  final _formKey = GlobalKey<FormState>();

  // Crime Post Controllers
  final GlobalKey<FormFieldState<String>> _crimeTitleKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _crimeDescriptionKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _crimeActionsKey =
      GlobalKey<FormFieldState<String>>();

  // Complaint Post Controllers
  final GlobalKey<FormFieldState<String>> _complaintTargetKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _complaintTitleKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _complaintDescriptionKey =
      GlobalKey<FormFieldState<String>>();
  String? complaintIsAnonymous;

  // Event Post Controllers
  final GlobalKey<FormFieldState<String>> _eventDateKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _eventTimeKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _eventVenueKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _eventTitleKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _eventDescriptionKey =
      GlobalKey<FormFieldState<String>>();

  // General Post Controllers
  final GlobalKey<FormFieldState<String>> _generalTitleKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _generalDescriptionKey =
      GlobalKey<FormFieldState<String>>();

  dynamic postData;
  dynamic groupID;
  dynamic postType;

  Validator validator = Validator();
  ApiService apiService = ApiService();
  PopupService popupService = PopupService();
  AuthService authService = AuthService();
  Settings settings = Settings();
  Utils utils = Utils();

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

  Form editCrimePostForm() {
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          key: _crimeTitleKey,
          initialValue: postData['title'],
          validator: (value) {
            return validator.validateTitle(value);
          },
          onChanged: (value) {
            _crimeTitleKey.currentState!.validate();
          },
          style: TextStyle(
              color: settings.editPostTextFieldTextColor,
              fontSize: 16,
              fontFamily: 'OpenSans'),
          cursorColor: settings.editPostTextFieldCursorColor,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: settings.editPostTextFieldTextColor),
            labelText: 'Title',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth + 1.0)),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          key: _crimeDescriptionKey,
          initialValue: postData['description'],
          validator: (value) {
            return validator.validateDescription(value);
          },
          onChanged: (value) {
            _crimeDescriptionKey.currentState!.validate();
          },
          style: TextStyle(
              color: settings.editPostTextFieldTextColor,
              fontSize: 16,
              fontFamily: 'OpenSans'),
          cursorColor: settings.editPostTextFieldCursorColor,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: settings.editPostTextFieldTextColor),
            labelText: 'Description',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth + 1.0)),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          key: _crimeActionsKey,
          initialValue: postData['actions'],
          validator: (value) {
            return validator.validateAction(value);
          },
          onChanged: (value) {
            _crimeActionsKey.currentState!.validate();
          },
          style: TextStyle(
              color: settings.editPostTextFieldTextColor,
              fontSize: 16,
              fontFamily: 'OpenSans'),
          cursorColor: settings.editPostTextFieldCursorColor,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: settings.editPostTextFieldTextColor),
            labelText: 'Actions',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth + 1.0)),
          ),
        ),
        const SizedBox(height: 16.0),
      ]),
    );
  }

  Form editComplaintPostForm() {
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          key: _complaintTargetKey,
          initialValue: postData['target'],
          validator: (value) {
            return validator.validateTarget(value);
          },
          onChanged: (value) {
            _complaintTargetKey.currentState!.validate();
          },
          style: TextStyle(
              color: settings.editPostTextFieldTextColor,
              fontSize: 16,
              fontFamily: 'OpenSans'),
          cursorColor: settings.editPostTextFieldCursorColor,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: settings.editPostTextFieldTextColor),
            labelText: 'Target',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth + 1.0)),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          key: _complaintTitleKey,
          initialValue: postData['title'],
          validator: (value) {
            return validator.validateTitle(value);
          },
          onChanged: (value) {
            _complaintTitleKey.currentState!.validate();
          },
          style: TextStyle(
              color: settings.editPostTextFieldTextColor,
              fontSize: 16,
              fontFamily: 'OpenSans'),
          cursorColor: settings.editPostTextFieldCursorColor,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: settings.editPostTextFieldTextColor),
            labelText: 'Title',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth + 1.0)),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          key: _complaintDescriptionKey,
          initialValue: postData['description'],
          validator: (value) {
            return validator.validateDescription(value);
          },
          onChanged: (value) {
            _complaintDescriptionKey.currentState!.validate();
          },
          style: TextStyle(
              color: settings.editPostTextFieldTextColor,
              fontSize: 16,
              fontFamily: 'OpenSans'),
          cursorColor: settings.editPostTextFieldCursorColor,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: settings.editPostTextFieldTextColor),
            labelText: 'Description',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth + 1.0)),
          ),
        ),
        const SizedBox(height: 16.0),
      ]),
    );
  }

  Form editEventPostForm() {
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          key: _eventDateKey,
          initialValue: postData['date'],
          validator: (value) {
            return validator.validateDate(value);
          },
          onChanged: (value) {
            _eventDateKey.currentState!.validate();
          },
          style: TextStyle(
              color: settings.editPostTextFieldTextColor,
              fontSize: 16,
              fontFamily: 'OpenSans'),
          cursorColor: settings.editPostTextFieldCursorColor,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: settings.editPostTextFieldTextColor),
            labelText: 'Date',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth + 1.0)),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          key: _eventTimeKey,
          initialValue: postData['time'],
          validator: (value) {
            return validator.validateTime(value);
          },
          onChanged: (value) {
            _eventTimeKey.currentState!.validate();
          },
          style: TextStyle(
              color: settings.editPostTextFieldTextColor,
              fontSize: 16,
              fontFamily: 'OpenSans'),
          cursorColor: settings.editPostTextFieldCursorColor,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: settings.editPostTextFieldTextColor),
            labelText: 'Time',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth + 1.0)),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          key: _eventVenueKey,
          initialValue: postData['venue'],
          validator: (value) {
            return validator.validateVenue(value);
          },
          onChanged: (value) {
            _eventVenueKey.currentState!.validate();
          },
          style: TextStyle(
              color: settings.editPostTextFieldTextColor,
              fontSize: 16,
              fontFamily: 'OpenSans'),
          cursorColor: settings.editPostTextFieldCursorColor,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: settings.editPostTextFieldTextColor),
            labelText: 'Venue',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth + 1.0)),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          key: _eventTitleKey,
          initialValue: postData['title'],
          validator: (value) {
            return validator.validateTitle(value);
          },
          onChanged: (value) {
            _eventTitleKey.currentState!.validate();
          },
          style: TextStyle(
              color: settings.editPostTextFieldTextColor,
              fontSize: 16,
              fontFamily: 'OpenSans'),
          cursorColor: settings.editPostTextFieldCursorColor,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: settings.editPostTextFieldTextColor),
            labelText: 'Title',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth + 1.0)),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          key: _eventDescriptionKey,
          initialValue: postData['description'],
          validator: (value) {
            return validator.validateDescription(value);
          },
          onChanged: (value) {
            _eventDescriptionKey.currentState!.validate();
          },
          style: TextStyle(
              color: settings.editPostTextFieldTextColor,
              fontSize: 16,
              fontFamily: 'OpenSans'),
          cursorColor: settings.editPostTextFieldCursorColor,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: settings.editPostTextFieldTextColor),
            labelText: 'Description',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth + 1.0)),
          ),
        ),
        const SizedBox(height: 16.0),
      ]),
    );
  }

  Form editGeneralPostForm() {
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          key: _generalTitleKey,
          initialValue: postData['title'],
          validator: (value) {
            return validator.validateTitle(value);
          },
          onChanged: (value) {
            _generalTitleKey.currentState!.validate();
          },
          style: TextStyle(
              color: settings.editPostTextFieldTextColor,
              fontSize: 16,
              fontFamily: 'OpenSans'),
          cursorColor: settings.editPostTextFieldCursorColor,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: settings.editPostTextFieldTextColor),
            labelText: 'Title',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth + 1.0)),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          key: _generalDescriptionKey,
          initialValue: postData['description'],
          validator: (value) {
            return validator.validateDescription(value);
          },
          onChanged: (value) {
            _generalDescriptionKey.currentState!.validate();
          },
          style: TextStyle(
              color: settings.editPostTextFieldTextColor,
              fontSize: 16,
              fontFamily: 'OpenSans'),
          cursorColor: settings.editPostTextFieldCursorColor,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: settings.editPostTextFieldTextColor),
            labelText: 'Description',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.editPostTextFieldBorderColor,
                    width: settings.editPostTextFieldBorderWidth + 1.0)),
          ),
        ),
        const SizedBox(height: 16.0),
      ]),
    );
  }

  void getData() async {
    final postResponse = await apiService.getAllNeighborhoodPostsAPI(
        {"token": authService.getAuthToken(), "groupID": groupID});
    if (postResponse != null) {
      final status = postResponse['status'];
      if (status > 0) {
        // Success
        setState(() {
          postData = postResponse['data'][postType]
              .where((post) => post['id'] == postData['id']);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      Map<String, String> dateTime =
          utils.splitDateTime(arguments['postData']['datetime']);
      setState(() {
        groupID = arguments['groupID'];
        postData = {
          ...arguments['postData'],
          'date': dateTime['date'],
          'time': dateTime['time']
        };
        postType = arguments['postType'];
      });

      return Scaffold(
        appBar: AppBar(
          backgroundColor: settings.editPostBgColor,
          title: Text('Edit ${utils.capitalizeFirstLetter(postType)} Post',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  fontFamily: "OpenSans",
                  color: settings.editPostTextFieldText2Color)),
          shadowColor: settings.editPostTextFieldShadowColor,
          elevation: 5.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              postType == 'crime'
                  ? editCrimePostForm()
                  : postType == 'complaint'
                      ? editComplaintPostForm()
                      : postType == 'event'
                          ? editEventPostForm()
                          : postType == 'general'
                              ? editGeneralPostForm()
                              : editCrimePostForm(),
              const SizedBox(height: 10.0),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                selectedImage != null
                    ? Icon(
                        Icons.done,
                        color: settings.editPostBgColor,
                        size: 40.0,
                      )
                    : Icon(Icons.cancel,
                        color: settings.editPostBgColor2, size: 40.0),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          settings.editPostTextFieldTextColor),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.fromLTRB(50, 20, 50, 20))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo,
                            color: settings.editPostTextFieldIconColor),
                        const SizedBox(width: 8),
                        Text('Add Image',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                fontFamily: "OpenSans",
                                color: settings.editPostTextFieldText2Color)),
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
                                  color: settings.editPostTextFieldTextColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'OpenSans')),
                          contentPadding:
                              const EdgeInsets.fromLTRB(0, 0, 10.0, 20.0),
                          actions: [
                            TextButton(
                              onPressed: () => _pickImage(ImageSource.gallery),
                              child: Text('Gallery',
                                  style: TextStyle(
                                      color:
                                          settings.editPostTextFieldTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'OpenSans')),
                            ),
                            TextButton(
                              onPressed: () => _pickImage(ImageSource.camera),
                              child: Text('Camera',
                                  style: TextStyle(
                                      color:
                                          settings.editPostTextFieldTextColor,
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
              const SizedBox(height: 30.0),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        settings.editPostTextFieldTextColor),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.fromLTRB(50, 20, 50, 20))),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.edit, color: settings.editPostTextFieldIconColor),
                  const SizedBox(width: 8),
                  Text('Edit Post',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          fontFamily: "OpenSans",
                          color: settings.editPostTextFieldText2Color)),
                ]),
                onPressed: () async {
                  if (postType == "crime") {
                    // Handle Crime Post Submit
                    Map<String, dynamic> crimeData = {
                      "title": _crimeTitleKey.currentState?.value,
                      "description": _crimeDescriptionKey.currentState?.value,
                      "actions": _crimeActionsKey.currentState?.value,
                      "image": selectedImage
                    };
                    if (!(_crimeTitleKey.currentState!.validate() &&
                        _crimeDescriptionKey.currentState!.validate() &&
                        _crimeActionsKey.currentState!.validate())) {
                      popupService.showErrorPopup(
                          context,
                          "Validation Message",
                          "Please ensure all fields are valid before submitting!",
                          () {});
                    } else {
                      // Filter out attributes that are not changed / updated by user
                      crimeData
                          .removeWhere((key, value) => postData[key] == value);
                      // Add token and crimePostID into crimeData
                      crimeData['crimePostID'] = postData['id'].toString();
                      crimeData['token'] = authService.getAuthToken();
                      final response =
                          await apiService.editCrimePostAPI(crimeData);
                      if (response != null) {
                        final status = response["status"];
                        final message = response["data"]["message"];
                        if (status > 0) {
                          // Success message
                          // ignore: use_build_context_synchronously
                          popupService.showSuccessPopup(
                              context, "Edit Crime Post Success", message, () {
                            setState(() {
                              selectedImage = null;
                            });
                            getData();
                          });
                        } else {
                          // Error message
                          // ignore: use_build_context_synchronously
                          popupService.showErrorPopup(
                              context, "Edit Crime Post Error", message, () {});
                        }
                      }
                    }
                  } else if (postType == "complaint") {
                    // Handle Complaint Post Submit
                    Map<String, dynamic> complaintData = {
                      "target": _complaintTargetKey.currentState?.value,
                      "title": _complaintTitleKey.currentState?.value,
                      "description":
                          _complaintDescriptionKey.currentState?.value,
                      "image": selectedImage
                    };
                    if (!(_complaintTargetKey.currentState!.validate() &&
                        _complaintTitleKey.currentState!.validate() &&
                        _complaintDescriptionKey.currentState!.validate())) {
                      popupService.showErrorPopup(
                          context,
                          "Validation Message",
                          "Please ensure all fields are valid before submitting!",
                          () {});
                    } else {
                      // Filter out attributes that are not changed / updated by user
                      complaintData
                          .removeWhere((key, value) => postData[key] == value);
                      // Add token and complaintPostID into complaintData
                      complaintData['complaintPostID'] =
                          postData['id'].toString();
                      complaintData['token'] = authService.getAuthToken();
                      final response =
                          await apiService.editComplaintPostAPI(complaintData);
                      if (response != null) {
                        final status = response["status"];
                        final message = response["data"]["message"];
                        if (status > 0) {
                          // Success message
                          // ignore: use_build_context_synchronously
                          popupService.showSuccessPopup(
                              context, "Edit Complaint Post Success", message,
                              () {
                            setState(() {
                              selectedImage = null;
                            });
                            getData();
                          });
                        } else {
                          // Error message
                          // ignore: use_build_context_synchronously
                          popupService.showErrorPopup(context,
                              "Edit Complaint Post Error", message, () {});
                        }
                      }
                    }
                  } else if (postType == "event") {
                    // Handle Event Post Submit
                    Map<String, dynamic> eventData = {
                      "date": _eventDateKey.currentState?.value,
                      "time": _eventTimeKey.currentState?.value,
                      "venue": _eventVenueKey.currentState?.value,
                      "title": _eventTitleKey.currentState?.value,
                      "description": _eventDescriptionKey.currentState?.value,
                      "image": selectedImage
                    };
                    if (!(_eventDateKey.currentState!.validate() &&
                        _eventTimeKey.currentState!.validate() &&
                        _eventVenueKey.currentState!.validate() &&
                        _eventTitleKey.currentState!.validate() &&
                        _eventDescriptionKey.currentState!.validate())) {
                      popupService.showErrorPopup(
                          context,
                          "Validation Message",
                          "Please ensure all fields are valid before submitting!",
                          () {});
                    } else {
                      // Filter out attributes that are not changed / updated by user
                      eventData.removeWhere((key, value) =>
                          postData[key] == value &&
                          key != 'date' &&
                          key != 'time');
                      // Add token and eventPostID into eventData
                      eventData['eventPostID'] = postData['id'].toString();
                      eventData['token'] = authService.getAuthToken();
                      final response =
                          await apiService.editEventPostAPI(eventData);
                      if (response != null) {
                        final status = response["status"];
                        final message = response["data"]["message"];
                        if (status > 0) {
                          // Success message
                          // ignore: use_build_context_synchronously
                          popupService.showSuccessPopup(
                              context, "Edit Event Post Success", message, () {
                            setState(() {
                              selectedImage = null;
                            });
                            getData();
                          });
                        } else {
                          // Error message
                          // ignore: use_build_context_synchronously
                          popupService.showErrorPopup(
                              context, "Edit Event Post Error", message, () {});
                        }
                      }
                    }
                  } else if (postType == "general") {
                    // Handle General Post Submit
                    Map<String, dynamic> generalData = {
                      "title": _generalTitleKey.currentState?.value,
                      "description": _generalDescriptionKey.currentState?.value,
                      "image": selectedImage
                    };
                    if (!(_generalTitleKey.currentState!.validate() &&
                        _generalDescriptionKey.currentState!.validate())) {
                      popupService.showErrorPopup(
                          context,
                          "Validation Message",
                          "Please ensure all fields are valid before submitting!",
                          () {});
                    } else {
                      // Filter out attributes that are not changed / updated by user
                      generalData
                          .removeWhere((key, value) => postData[key] == value);
                      // Add token and eventPostID into eventData
                      generalData['generalPostID'] = postData['id'].toString();
                      generalData['token'] = authService.getAuthToken();
                      final response =
                          await apiService.editGeneralPostAPI(generalData);
                      if (response != null) {
                        final status = response["status"];
                        final message = response["data"]["message"];
                        if (status > 0) {
                          // Success message
                          // ignore: use_build_context_synchronously
                          popupService.showSuccessPopup(
                              context, "Edit General Post Success", message,
                              () {
                            setState(() {
                              selectedImage = null;
                            });
                            getData();
                          });
                        } else {
                          // Error message
                          // ignore: use_build_context_synchronously
                          popupService.showErrorPopup(context,
                              "Edit General Post Error", message, () {});
                        }
                      }
                    }
                  }
                },
              ),
            ],
          )),
        ),
      );
    } else {
      return Container();
    }
  }
}
