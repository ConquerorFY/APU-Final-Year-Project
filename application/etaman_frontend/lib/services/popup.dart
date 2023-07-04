import 'package:flutter/material.dart';

class MessagePopup extends StatelessWidget {
  final String title;
  final String message;
  final Color backgroundColor;
  final Color textColor;

  const MessagePopup({
    super.key,
    required this.title,
    required this.message,
    this.backgroundColor = Colors.green,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.8)),
        ),
        const SizedBox(height: 5.0),
        Text(
          title,
          style: TextStyle(
              color: textColor,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              fontFamily: "OpenSans"),
        ),
        const SizedBox(height: 5.0),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0)),
        )
      ]),
      titlePadding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
      content: Text(
        message,
        style: TextStyle(
            color: textColor,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: "OpenSans"),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      buttonPadding: const EdgeInsets.fromLTRB(10, 10, 24, 10),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Close the popup when this button is pressed
            Navigator.of(context).pop();
          },
          child: Text(
            "Close",
            style: TextStyle(
                color: textColor,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontFamily: "OpenSans"),
          ),
        ),
      ],
    );
  }
}

class Popup {
  // Create Singleton instance
  Popup._();
  static final Popup _instance = Popup._();
  factory Popup() => _instance;

  void showSuccessPopup(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MessagePopup(
          title: title,
          message: message,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      },
    );
  }

  void showErrorPopup(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MessagePopup(
          title: title,
          message: message,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      },
    );
  }
}
