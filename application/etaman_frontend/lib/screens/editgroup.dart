import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:etaman_frontend/services/validator.dart';
import 'package:flutter/material.dart';
import 'package:etaman_frontend/services/api.dart';

class EditGroup extends StatefulWidget {
  const EditGroup({super.key});

  @override
  EditGroupState createState() => EditGroupState();
}

class EditGroupState extends State<EditGroup> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState<String>> _nameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _ruleKey =
      GlobalKey<FormFieldState<String>>();

  dynamic groupData;

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
          groupData = {
            "id": responseData['data']['list']['groupID'],
            "name": responseData['data']['list']['groupName'],
            "rule": responseData['data']['list']['groupRule']
          };
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: settings.editGroupBgColor,
          title: Text('Edit Neighborhood Group',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  fontFamily: "OpenSans",
                  color: settings.editGroupTextFieldText2Color)),
          shadowColor: settings.editGroupTextFieldShadowColor,
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
                      initialValue: groupData['name'],
                      validator: (value) {
                        return validator.validateName(value);
                      },
                      onChanged: (value) {
                        _nameKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.editGroupTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.editGroupTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.editGroupTextFieldTextColor),
                        labelText: 'Group Name',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editGroupTextFieldBorderColor,
                                width: settings.editGroupTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editGroupTextFieldBorderColor,
                                width: settings.editGroupTextFieldBorderWidth +
                                    1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      key: _ruleKey,
                      initialValue: groupData['rule'],
                      validator: (value) {
                        return validator.validateRules(value);
                      },
                      onChanged: (value) {
                        _ruleKey.currentState!.validate();
                      },
                      style: TextStyle(
                          color: settings.editGroupTextFieldTextColor,
                          fontSize: 16,
                          fontFamily: 'OpenSans'),
                      cursorColor: settings.editGroupTextFieldCursorColor,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: settings.editGroupTextFieldTextColor),
                        labelText: 'Group Rules',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editGroupTextFieldBorderColor,
                                width: settings.editGroupTextFieldBorderWidth)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: settings.editGroupTextFieldBorderColor,
                                width: settings.editGroupTextFieldBorderWidth +
                                    1.0)),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ]),
                ),
                ElevatedButton(
                    onPressed: () async {
                      // Handle edit group process
                      // For group name
                      Map<String, dynamic> nameData = {
                        "groupId": groupData['id'],
                        "name": _nameKey.currentState?.value,
                        "token": authService.getAuthToken()
                      };
                      // For group rule
                      Map<String, dynamic> ruleData = {
                        "groupId": groupData['id'],
                        "rules": _ruleKey.currentState?.value,
                        "token": authService.getAuthToken()
                      };
                      if (!(_nameKey.currentState!.validate() &&
                          _ruleKey.currentState!.validate())) {
                        popupService.showErrorPopup(
                            context,
                            "Validation Message",
                            "Please ensure all fields are valid before submitting!",
                            () {});
                      } else {
                        // Update Group Name First
                        final nameResponse = await apiService
                            .updateNeighborhoodGroupNameAPI(nameData);
                        if (nameResponse != null) {
                          final nameStatus = nameResponse["status"];
                          final nameMessage = nameResponse["data"]["message"];
                          if (nameStatus > 0) {
                            // Success message
                            // ignore: use_build_context_synchronously
                            popupService.showSuccessPopup(
                                context, "Edit Group Name Success", nameMessage,
                                () async {
                              final rulesResponse = await apiService
                                  .updateNeighborhoodGroupRuleAPI(ruleData);
                              if (rulesResponse != null) {
                                final rulesStatus = rulesResponse['status'];
                                final rulesMessage =
                                    rulesResponse["data"]["message"];
                                if (rulesStatus > 0) {
                                  // Success message
                                  // ignore: use_build_context_synchronously
                                  popupService.showSuccessPopup(
                                      context,
                                      "Edit Group Rule Success",
                                      rulesMessage, () {
                                    getData();
                                  });
                                } else {
                                  // Error message
                                  // ignore: use_build_context_synchronously
                                  popupService.showErrorPopup(
                                      context,
                                      "Edit Group Rule Error",
                                      rulesMessage,
                                      () {});
                                }
                              }
                            });
                          } else {
                            // Error message
                            // ignore: use_build_context_synchronously
                            popupService.showErrorPopup(
                                context, "Edit Group Name Error", nameMessage,
                                () async {
                              final rulesResponse = await apiService
                                  .updateNeighborhoodGroupRuleAPI(ruleData);
                              if (rulesResponse != null) {
                                final rulesStatus = rulesResponse['status'];
                                final rulesMessage =
                                    rulesResponse["data"]["message"];
                                if (rulesStatus > 0) {
                                  // Success message
                                  // ignore: use_build_context_synchronously
                                  popupService.showSuccessPopup(
                                      context,
                                      "Edit Group Rule Success",
                                      rulesMessage, () {
                                    getData();
                                  });
                                } else {
                                  // Error message
                                  // ignore: use_build_context_synchronously
                                  popupService.showErrorPopup(
                                      context,
                                      "Edit Group Rule Error",
                                      rulesMessage,
                                      () {});
                                }
                              }
                            });
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            settings.editGroupTextFieldTextColor),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.fromLTRB(50, 20, 50, 20))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit,
                              color: settings.editGroupTextFieldIconColor),
                          const SizedBox(width: 8),
                          Text('Edit',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "OpenSans",
                                  color:
                                      settings.editGroupTextFieldText2Color)),
                        ])),
              ],
            ),
          ),
        ));
  }
}
