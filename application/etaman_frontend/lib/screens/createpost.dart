import 'dart:io';
import 'package:etaman_frontend/services/api.dart';
import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:etaman_frontend/services/validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  CreatePostState createState() => CreatePostState();
}

class CreatePostState extends State<CreatePost> {
  String selectedPostType = 'Crime Post';
  List<String> postTypes = [
    'Crime Post',
    'Complaint Post',
    'Event Post',
    'General Post'
  ];
  File? selectedImage;
  final _formKey = GlobalKey<FormState>();

  // Crime Post Controllers
  final GlobalKey<FormFieldState<String>> _crimeDateKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _crimeTimeKey =
      GlobalKey<FormFieldState<String>>();
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

  Validator validator = Validator();
  ApiService apiService = ApiService();
  PopupService popupService = PopupService();
  AuthService authService = AuthService();
  Settings settings = Settings();

  @override
  void initState() {
    super.initState();
    resetData();
  }

  void resetData() {
    _formKey.currentState?.reset();
    complaintIsAnonymous = null;
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

  Form createCrimePostForm() {
    return Form(
      key: _formKey,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        TextFormField(
          key: _crimeDateKey,
          initialValue: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          readOnly: true,
          validator: (value) {
            return validator.validateDate(value);
          },
          onChanged: (value) {
            _crimeDateKey.currentState!.validate();
          },
          style: TextStyle(
              color: settings.createPostTextFieldTextColor,
              fontSize: 16,
              fontFamily: 'OpenSans'),
          cursorColor: settings.createPostTextFieldCursorColor,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: settings.createPostTextFieldTextColor),
            labelText: 'Date',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.createPostTextFieldBorderColor,
                    width: settings.createPostTextFieldBorderWidth)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.createPostTextFieldBorderColor,
                    width: settings.createPostTextFieldBorderWidth + 1.0)),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
            key: _crimeTimeKey,
            initialValue: DateFormat('HH:mm:ss').format(DateTime.now()),
            readOnly: true,
            validator: (value) {
              return validator.validateTime(value);
            },
            onChanged: (value) {
              _crimeTimeKey.currentState!.validate();
            },
            style: TextStyle(
                color: settings.createPostTextFieldTextColor,
                fontSize: 16,
                fontFamily: 'OpenSans'),
            cursorColor: settings.createPostTextFieldCursorColor,
            decoration: InputDecoration(
              labelStyle:
                  TextStyle(color: settings.createPostTextFieldTextColor),
              labelText: 'Time',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth + 1.0)),
            )),
        const SizedBox(height: 16.0),
        TextFormField(
            key: _crimeTitleKey,
            validator: (value) {
              return validator.validateTitle(value);
            },
            onChanged: (value) {
              _crimeTitleKey.currentState!.validate();
            },
            style: TextStyle(
                color: settings.createPostTextFieldTextColor,
                fontSize: 16,
                fontFamily: 'OpenSans'),
            cursorColor: settings.createPostTextFieldCursorColor,
            decoration: InputDecoration(
              labelStyle:
                  TextStyle(color: settings.createPostTextFieldTextColor),
              labelText: 'Title',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth + 1.0)),
            )),
        const SizedBox(height: 16.0),
        TextFormField(
            key: _crimeDescriptionKey,
            validator: (value) {
              return validator.validateDescription(value);
            },
            onChanged: (value) {
              _crimeDescriptionKey.currentState!.validate();
            },
            style: TextStyle(
                color: settings.createPostTextFieldTextColor,
                fontSize: 16,
                fontFamily: 'OpenSans'),
            cursorColor: settings.createPostTextFieldCursorColor,
            decoration: InputDecoration(
              labelStyle:
                  TextStyle(color: settings.createPostTextFieldTextColor),
              labelText: 'Description',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth + 1.0)),
            )),
        const SizedBox(height: 16.0),
        TextFormField(
            key: _crimeActionsKey,
            validator: (value) {
              return validator.validateAction(value);
            },
            onChanged: (value) {
              _crimeActionsKey.currentState!.validate();
            },
            style: TextStyle(
                color: settings.createPostTextFieldTextColor,
                fontSize: 16,
                fontFamily: 'OpenSans'),
            cursorColor: settings.createPostTextFieldCursorColor,
            decoration: InputDecoration(
              labelStyle:
                  TextStyle(color: settings.createPostTextFieldTextColor),
              labelText: 'Actions',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth + 1.0)),
            )),
      ]),
    );
  }

  Form createComplaintPostForm() {
    return Form(
      key: _formKey,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        TextFormField(
            key: _complaintTargetKey,
            validator: (value) {
              return validator.validateTarget(value);
            },
            onChanged: (value) {
              _complaintTargetKey.currentState!.validate();
            },
            style: TextStyle(
                color: settings.createPostTextFieldTextColor,
                fontSize: 16,
                fontFamily: 'OpenSans'),
            cursorColor: settings.createPostTextFieldCursorColor,
            decoration: InputDecoration(
              labelStyle:
                  TextStyle(color: settings.createPostTextFieldTextColor),
              labelText: 'Target',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth + 1.0)),
            )),
        const SizedBox(height: 16.0),
        TextFormField(
            key: _complaintTitleKey,
            validator: (value) {
              return validator.validateTitle(value);
            },
            onChanged: (value) {
              _complaintTitleKey.currentState!.validate();
            },
            style: TextStyle(
                color: settings.createPostTextFieldTextColor,
                fontSize: 16,
                fontFamily: 'OpenSans'),
            cursorColor: settings.createPostTextFieldCursorColor,
            decoration: InputDecoration(
              labelStyle:
                  TextStyle(color: settings.createPostTextFieldTextColor),
              labelText: 'Title',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth + 1.0)),
            )),
        const SizedBox(height: 16.0),
        TextFormField(
            key: _complaintDescriptionKey,
            validator: (value) {
              return validator.validateDescription(value);
            },
            onChanged: (value) {
              _complaintDescriptionKey.currentState!.validate();
            },
            style: TextStyle(
                color: settings.createPostTextFieldTextColor,
                fontSize: 16,
                fontFamily: 'OpenSans'),
            cursorColor: settings.createPostTextFieldCursorColor,
            decoration: InputDecoration(
              labelStyle:
                  TextStyle(color: settings.createPostTextFieldTextColor),
              labelText: 'Description',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth + 1.0)),
            )),
        const SizedBox(height: 16.0),
        RadioListTile<String>(
          title: Text('Show Username in Post',
              style: TextStyle(
                  color: settings.createPostTextFieldTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: 'OpenSans')),
          value: "false",
          groupValue: complaintIsAnonymous,
          onChanged: (value) {
            setState(() {
              complaintIsAnonymous = value;
            });
          },
        ),
        RadioListTile<String>(
            title: Text('Hide Username in Post',
                style: TextStyle(
                    color: settings.createPostTextFieldTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    fontFamily: 'OpenSans')),
            value: "true",
            groupValue: complaintIsAnonymous,
            onChanged: (value) {
              setState(() {
                complaintIsAnonymous = value;
              });
            }),
      ]),
    );
  }

  Form createEventPostForm() {
    return Form(
      key: _formKey,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        TextFormField(
          key: _eventDateKey,
          initialValue: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          validator: (value) {
            return validator.validateDate(value);
          },
          onChanged: (value) {
            _eventDateKey.currentState!.validate();
          },
          style: TextStyle(
              color: settings.createPostTextFieldTextColor,
              fontSize: 16,
              fontFamily: 'OpenSans'),
          cursorColor: settings.createPostTextFieldCursorColor,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: settings.createPostTextFieldTextColor),
            labelText: 'Date',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.createPostTextFieldBorderColor,
                    width: settings.createPostTextFieldBorderWidth)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: settings.createPostTextFieldBorderColor,
                    width: settings.createPostTextFieldBorderWidth + 1.0)),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
            key: _eventTimeKey,
            initialValue: DateFormat('HH:mm:ss').format(DateTime.now()),
            validator: (value) {
              return validator.validateTime(value);
            },
            onChanged: (value) {
              _eventTimeKey.currentState!.validate();
            },
            style: TextStyle(
                color: settings.createPostTextFieldTextColor,
                fontSize: 16,
                fontFamily: 'OpenSans'),
            cursorColor: settings.createPostTextFieldCursorColor,
            decoration: InputDecoration(
              labelStyle:
                  TextStyle(color: settings.createPostTextFieldTextColor),
              labelText: 'Time',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth + 1.0)),
            )),
        const SizedBox(height: 16.0),
        TextFormField(
            key: _eventVenueKey,
            validator: (value) {
              return validator.validateVenue(value);
            },
            onChanged: (value) {
              _eventVenueKey.currentState!.validate();
            },
            style: TextStyle(
                color: settings.createPostTextFieldTextColor,
                fontSize: 16,
                fontFamily: 'OpenSans'),
            cursorColor: settings.createPostTextFieldCursorColor,
            decoration: InputDecoration(
              labelStyle:
                  TextStyle(color: settings.createPostTextFieldTextColor),
              labelText: 'Venue',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth + 1.0)),
            )),
        const SizedBox(height: 16.0),
        TextFormField(
            key: _eventTitleKey,
            validator: (value) {
              return validator.validateTitle(value);
            },
            onChanged: (value) {
              _eventTitleKey.currentState!.validate();
            },
            style: TextStyle(
                color: settings.createPostTextFieldTextColor,
                fontSize: 16,
                fontFamily: 'OpenSans'),
            cursorColor: settings.createPostTextFieldCursorColor,
            decoration: InputDecoration(
              labelStyle:
                  TextStyle(color: settings.createPostTextFieldTextColor),
              labelText: 'Title',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth + 1.0)),
            )),
        const SizedBox(height: 16.0),
        TextFormField(
            key: _eventDescriptionKey,
            validator: (value) {
              return validator.validateDescription(value);
            },
            onChanged: (value) {
              _eventDescriptionKey.currentState!.validate();
            },
            style: TextStyle(
                color: settings.createPostTextFieldTextColor,
                fontSize: 16,
                fontFamily: 'OpenSans'),
            cursorColor: settings.createPostTextFieldCursorColor,
            decoration: InputDecoration(
              labelStyle:
                  TextStyle(color: settings.createPostTextFieldTextColor),
              labelText: 'Description',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth + 1.0)),
            )),
        const SizedBox(height: 16.0),
      ]),
    );
  }

  Form createGeneralPostForm() {
    return Form(
      key: _formKey,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        TextFormField(
            key: _generalTitleKey,
            validator: (value) {
              return validator.validateTitle(value);
            },
            onChanged: (value) {
              _generalTitleKey.currentState!.validate();
            },
            style: TextStyle(
                color: settings.createPostTextFieldTextColor,
                fontSize: 16,
                fontFamily: 'OpenSans'),
            cursorColor: settings.createPostTextFieldCursorColor,
            decoration: InputDecoration(
              labelStyle:
                  TextStyle(color: settings.createPostTextFieldTextColor),
              labelText: 'Title',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth + 1.0)),
            )),
        const SizedBox(height: 16.0),
        TextFormField(
            key: _generalDescriptionKey,
            validator: (value) {
              return validator.validateDescription(value);
            },
            onChanged: (value) {
              _generalDescriptionKey.currentState!.validate();
            },
            style: TextStyle(
                color: settings.createPostTextFieldTextColor,
                fontSize: 16,
                fontFamily: 'OpenSans'),
            cursorColor: settings.createPostTextFieldCursorColor,
            decoration: InputDecoration(
              labelStyle:
                  TextStyle(color: settings.createPostTextFieldTextColor),
              labelText: 'Description',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: settings.createPostTextFieldBorderColor,
                      width: settings.createPostTextFieldBorderWidth + 1.0)),
            )),
        const SizedBox(height: 16.0),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: settings.createPostBgColor,
        title: Text('Create Post',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                fontFamily: "OpenSans",
                color: settings.createPostTextFieldText2Color)),
        shadowColor: settings.createPostTextFieldShadowColor,
        elevation: 5.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text("Post Type: ",
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: settings.createPostTextFieldTextColor)),
              const SizedBox(width: 20.0),
              DropdownButton<String>(
                value: selectedPostType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPostType = newValue!;
                  });
                },
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: settings.createPostTextFieldTextColor),
                items: postTypes.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ]),
            const SizedBox(height: 30.0),
            selectedPostType == 'Crime Post'
                ? createCrimePostForm()
                : selectedPostType == 'Complaint Post'
                    ? createComplaintPostForm()
                    : selectedPostType == 'Event Post'
                        ? createEventPostForm()
                        : selectedPostType == 'General Post'
                            ? createGeneralPostForm()
                            : createComplaintPostForm(),
            const SizedBox(height: 40.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              selectedImage != null
                  ? Icon(
                      Icons.done,
                      color: settings.createPostBgColor,
                      size: 40.0,
                    )
                  : Icon(Icons.cancel,
                      color: settings.createPostBgColor2, size: 40.0),
              const SizedBox(width: 20.0),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        settings.createPostTextFieldTextColor),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.fromLTRB(50, 20, 50, 20))),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.add_a_photo,
                      color: settings.createPostTextFieldIconColor),
                  const SizedBox(width: 8),
                  Text('Add Image',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          fontFamily: "OpenSans",
                          color: settings.createPostTextFieldText2Color)),
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
                                color: settings.createPostTextFieldTextColor,
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
                                        settings.createPostTextFieldTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'OpenSans')),
                          ),
                          TextButton(
                            onPressed: () => _pickImage(ImageSource.camera),
                            child: Text('Camera',
                                style: TextStyle(
                                    color:
                                        settings.createPostTextFieldTextColor,
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
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      settings.createPostTextFieldTextColor),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.fromLTRB(50, 20, 50, 20))),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.add, color: settings.createPostTextFieldIconColor),
                const SizedBox(width: 8),
                Text('Submit Post',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        fontFamily: "OpenSans",
                        color: settings.createPostTextFieldText2Color)),
              ]),
              onPressed: () async {
                if (selectedPostType == "Crime Post") {
                  // Handle Crime Post Submit
                  Map<String, dynamic> crimePostData = {
                    "date": _crimeDateKey.currentState?.value,
                    "time": _crimeTimeKey.currentState?.value,
                    "title": _crimeTitleKey.currentState?.value,
                    "description": _crimeDescriptionKey.currentState?.value,
                    "actions": _crimeActionsKey.currentState?.value,
                    "token": authService.getAuthToken(),
                    "image": selectedImage
                  };
                  if (!(_crimeDateKey.currentState!.validate() &&
                      _crimeTimeKey.currentState!.validate() &&
                      _crimeTitleKey.currentState!.validate() &&
                      _crimeDescriptionKey.currentState!.validate() &&
                      _crimeActionsKey.currentState!.validate() &&
                      selectedImage != null)) {
                    popupService.showErrorPopup(
                        context,
                        "Validation Message",
                        "Please ensure all fields are valid before submitting!",
                        () {});
                  } else {
                    final response =
                        await apiService.submitCrimePostAPI(crimePostData);
                    if (response != null) {
                      final status = response["status"];
                      final message = response["data"]["message"];
                      if (status > 0) {
                        // Success message
                        // ignore: use_build_context_synchronously
                        popupService.showSuccessPopup(
                            context, "Create Crime Post Success", message, () {
                          resetData();
                        });
                      } else {
                        // Error message
                        // ignore: use_build_context_synchronously
                        popupService.showErrorPopup(
                            context, "Create Crime Post Error", message, () {});
                      }
                    }
                  }
                } else if (selectedPostType == "Complaint Post") {
                  // Handle Complaint Post Submit
                  Map<String, dynamic> complaintPostData = {
                    "target": _complaintTargetKey.currentState?.value,
                    "title": _complaintTitleKey.currentState?.value,
                    "description": _complaintDescriptionKey.currentState?.value,
                    "isAnonymous": complaintIsAnonymous,
                    "token": authService.getAuthToken(),
                    "image": selectedImage
                  };
                  if (!(_complaintTargetKey.currentState!.validate() &&
                      _complaintTitleKey.currentState!.validate() &&
                      _complaintDescriptionKey.currentState!.validate() &&
                      complaintIsAnonymous != null)) {
                    popupService.showErrorPopup(
                        context,
                        "Validation Message",
                        "Please ensure all fields are valid before submitting!",
                        () {});
                  } else {
                    final response = await apiService
                        .submitComplaintPostAPI(complaintPostData);
                    if (response != null) {
                      final status = response["status"];
                      final message = response["data"]["message"];
                      if (status > 0) {
                        // Success message
                        // ignore: use_build_context_synchronously
                        popupService.showSuccessPopup(
                            context, "Create Complaint Post Success", message,
                            () {
                          resetData();
                        });
                      } else {
                        // Error message
                        // ignore: use_build_context_synchronously
                        popupService.showErrorPopup(context,
                            "Create Complaint Post Error", message, () {});
                      }
                    }
                  }
                } else if (selectedPostType == "Event Post") {
                  // Handle Event Post Submit
                  Map<String, dynamic> eventPostData = {
                    "date": _eventDateKey.currentState?.value,
                    "time": _eventTimeKey.currentState?.value,
                    "venue": _eventVenueKey.currentState?.value,
                    "title": _eventTitleKey.currentState?.value,
                    "description": _eventDescriptionKey.currentState?.value,
                    "participants": "",
                    "token": authService.getAuthToken(),
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
                    final response =
                        await apiService.submitEventPostAPI(eventPostData);
                    if (response != null) {
                      final status = response["status"];
                      final message = response["data"]["message"];
                      if (status > 0) {
                        // Success message
                        // ignore: use_build_context_synchronously
                        popupService.showSuccessPopup(
                            context, "Create Event Post Success", message, () {
                          resetData();
                        });
                      } else {
                        // Error message
                        // ignore: use_build_context_synchronously
                        popupService.showErrorPopup(
                            context, "Create Event Post Error", message, () {});
                      }
                    }
                  }
                } else if (selectedPostType == "General Post") {
                  // Handle General Post Submit
                  Map<String, dynamic> generalPostData = {
                    "title": _generalTitleKey.currentState?.value,
                    "description": _generalDescriptionKey.currentState?.value,
                    "token": authService.getAuthToken(),
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
                    final response =
                        await apiService.submitGeneralPostAPI(generalPostData);
                    if (response != null) {
                      final status = response["status"];
                      final message = response["data"]["message"];
                      if (status > 0) {
                        // Success message
                        // ignore: use_build_context_synchronously
                        popupService.showSuccessPopup(
                            context, "Create General Post Success", message,
                            () {
                          resetData();
                        });
                      } else {
                        // Error message
                        // ignore: use_build_context_synchronously
                        popupService.showErrorPopup(context,
                            "Create General Post Error", message, () {});
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
  }
}
