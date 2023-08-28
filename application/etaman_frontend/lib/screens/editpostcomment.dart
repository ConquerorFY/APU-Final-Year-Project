import 'dart:io';

import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:etaman_frontend/services/utils.dart';
import 'package:etaman_frontend/services/validator.dart';
import 'package:flutter/material.dart';
import 'package:etaman_frontend/services/api.dart';

class EditPostComment extends StatefulWidget {
  const EditPostComment({super.key});

  @override
  EditPostCommentState createState() => EditPostCommentState();
}

class EditPostCommentState extends State<EditPostComment> {
  File? selectedImage;
  final _formKey = GlobalKey<FormState>();

  // Crime Post Controllers
  final GlobalKey<FormFieldState<String>> _contentKey =
      GlobalKey<FormFieldState<String>>();

  dynamic commentID;
  dynamic commentData;
  dynamic commentType;

  Validator validator = Validator();
  ApiService apiService = ApiService();
  PopupService popupService = PopupService();
  AuthService authService = AuthService();
  Settings settings = Settings();
  Utils utils = Utils();

  void getData() async {
    dynamic apiFunction;
    if (commentType == 'crime') {
      apiFunction = apiService.getAllCrimePostCommentsAPI;
    } else if (commentType == 'complaint') {
      apiFunction = apiService.getAllComplaintPostCommentsAPI;
    } else if (commentType == 'event') {
      apiFunction = apiService.getAllEventPostCommentsAPI;
    } else if (commentType == 'general') {
      apiFunction = apiService.getAllGeneralPostCommentsAPI;
    }

    final commentResponse =
        await apiFunction({"${commentType}PostID": commentData['postID']});
    if (commentResponse != null) {
      final status = commentResponse['status'];
      if (status > 0) {
        // Success
        setState(() {
          commentData = commentResponse['data']['comments']
              .where((comment) => comment['id'] == commentID);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      setState(() {
        commentData = arguments['commentData'];
        commentType = arguments['commentType'];
        commentID = arguments['commentID'];
      });

      return Scaffold(
        appBar: AppBar(
          backgroundColor: settings.editPostCommentBgColor,
          title: Text(
              'Edit ${utils.capitalizeFirstLetter(commentType)} Post Comment',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  fontFamily: "OpenSans",
                  color: settings.editPostCommentTextFieldText2Color)),
          shadowColor: settings.editPostCommentTextFieldShadowColor,
          elevation: 5.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    key: _contentKey,
                    initialValue: commentData['content'],
                    validator: (value) {
                      return validator.validateContent(value);
                    },
                    onChanged: (value) {
                      _contentKey.currentState!.validate();
                    },
                    style: TextStyle(
                        color: settings.editPostCommentTextFieldTextColor,
                        fontSize: 16,
                        fontFamily: 'OpenSans'),
                    cursorColor: settings.editPostCommentTextFieldCursorColor,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: settings.editPostCommentTextFieldTextColor),
                      labelText: 'Content',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  settings.editPostCommentTextFieldBorderColor,
                              width: settings
                                  .editPostCommentTextFieldBorderWidth)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  settings.editPostCommentTextFieldBorderColor,
                              width:
                                  settings.editPostCommentTextFieldBorderWidth +
                                      1.0)),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        settings.editPostCommentTextFieldTextColor),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.fromLTRB(50, 20, 50, 20))),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.edit,
                      color: settings.editPostCommentTextFieldIconColor),
                  const SizedBox(width: 8),
                  Text('Edit Comment',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          fontFamily: "OpenSans",
                          color: settings.editPostCommentTextFieldText2Color)),
                ]),
                onPressed: () async {
                  // Handle Edit Comment Function
                  Map<String, dynamic> cData = {
                    "${commentType}PostCommentID": commentID.toString(),
                    "token": authService.getAuthToken(),
                    "content": _contentKey.currentState?.value
                  };

                  dynamic apiFunction;
                  if (commentType == 'crime') {
                    apiFunction = apiService.editCrimePostCommentAPI;
                  } else if (commentType == 'complaint') {
                    apiFunction = apiService.editComplaintPostCommentAPI;
                  } else if (commentType == 'event') {
                    apiFunction = apiService.editEventPostCommentAPI;
                  } else if (commentType == 'general') {
                    apiFunction = apiService.editGeneralPostCommentAPI;
                  }

                  final commentResponse = await apiFunction(cData);
                  if (apiFunction != null) {
                    final status = commentResponse['status'];
                    final message = commentResponse['data']['message'];
                    if (status > 0) {
                      // Success
                      // ignore: use_build_context_synchronously
                      popupService.showSuccessPopup(
                          context, "Edit Comment Success", message, () {
                        getData();
                      });
                    } else {
                      // Error
                      // ignore: use_build_context_synchronously
                      popupService.showErrorPopup(
                          context, "Edit Comment Error", message, () {});
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
