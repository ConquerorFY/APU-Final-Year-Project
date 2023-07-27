import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';

class MessagePopup extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Function onPress;

  const MessagePopup({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    required this.onPress,
    this.backgroundColor = Colors.green,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      title: Wrap(children: [
        Icon(
          icon,
          color: textColor,
          size: 23.0,
        ),
        const SizedBox(width: 8.0),
        Text(
          title,
          style: TextStyle(
              color: textColor,
              fontSize: 16.38,
              fontWeight: FontWeight.w800,
              fontFamily: "OpenSans"),
        ),
      ]),
      titlePadding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      content: Text(
        message,
        style: TextStyle(
            color: textColor,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontFamily: "OpenSans"),
      ),
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      buttonPadding: const EdgeInsets.fromLTRB(10, 10, 24, 10),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Close the popup when this button is pressed
            Navigator.of(context).pop();
            onPress();
          },
          child: const Text(
            "OK",
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontFamily: "OpenSans"),
          ),
        ),
      ],
    );
  }
}

class PopupService {
  // Create Singleton instance
  PopupService._();
  static final PopupService _instance = PopupService._();
  factory PopupService() => _instance;

  final Settings settings = Settings(); // Settings Service

  showSuccessPopup(
      BuildContext context, String title, String message, Function onPress) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MessagePopup(
          title: title,
          message: message,
          icon: Icons.info_outline_rounded,
          backgroundColor: settings.popupBgColor,
          textColor: settings.successPopupTextColor,
          onPress: onPress,
        );
      },
    );
  }

  void showErrorPopup(
      BuildContext context, String title, String message, Function onPress) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MessagePopup(
          title: title,
          message: message,
          icon: Icons.warning_amber_rounded,
          backgroundColor: settings.popupBgColor,
          textColor: settings.errorPopupTextColor,
          onPress: onPress,
        );
      },
    );
  }
}
