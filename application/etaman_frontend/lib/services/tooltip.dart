import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InteractiveTooltip extends StatelessWidget {
  final Widget child;
  final String message;
  dynamic height;
  final VoidCallback onTap;

  Settings settings = Settings();

  InteractiveTooltip(
      {super.key,
      required this.child,
      required this.message,
      this.height,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onTap,
      child: Tooltip(
          waitDuration: Duration(seconds: settings.mapWaitDuration),
          showDuration: Duration(seconds: settings.mapShowDuration),
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
          textStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 10,
              color: settings.mapTooltipTextColor,
              fontWeight: FontWeight.bold),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: settings.mapTooltipBgColor),
          height: height,
          message: message,
          triggerMode: TooltipTriggerMode.tap,
          child: child),
    );
  }
}
