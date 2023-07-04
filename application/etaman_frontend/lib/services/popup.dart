import 'package:flutter/material.dart';

class MessagePopup extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;

  const MessagePopup({
    super.key,
    required this.message,
    this.backgroundColor = Colors.green,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor,
        padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: backgroundColor, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            message,
            style: TextStyle(
                color: textColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: "OpenSans"),
          ),
        ));
  }
}

class Popup {
  // Create Singleton instance
  Popup._();
  static final Popup _instance = Popup._();
  factory Popup() => _instance;

  void showSuccessPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            child: MessagePopup(
          message: message,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        ));
      },
    );
  }

  void showErrorPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: MessagePopup(
            message: message,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          ),
        );
      },
    );
  }
}
