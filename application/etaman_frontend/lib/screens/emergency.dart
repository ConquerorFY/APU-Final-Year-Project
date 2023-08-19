import 'dart:math';

import 'package:etaman_frontend/services/api.dart';
import 'package:etaman_frontend/services/auth.dart';
import 'package:etaman_frontend/services/components.dart';
import 'package:etaman_frontend/services/popup.dart';
import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';

class PizzaButton extends StatelessWidget {
  final VoidCallback crimeEmergency;
  final VoidCallback medicalEmergency;
  final VoidCallback fireEmergency;

  const PizzaButton({
    super.key,
    required this.crimeEmergency,
    required this.medicalEmergency,
    required this.fireEmergency,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        final double width = MediaQuery.of(context).size.width;
        final double height = MediaQuery.of(context).size.height;
        final double centerX = width / 2;
        final double centerY = height / 2;
        final double dx = details.globalPosition.dx;
        final double dy = details.globalPosition.dy;

        final double angle = atan2(dy - centerY, dx - centerX);

        if (angle >= -pi / 3 && angle <= pi / 3) {
          crimeEmergency();
        } else if (angle > pi / 3 && angle <= pi) {
          medicalEmergency();
        } else if (angle < -pi / 3 && angle >= -pi) {
          fireEmergency();
        }
      },
      child: CustomPaint(
        painter: PizzaPainter(),
        child: const SizedBox(
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}

class PizzaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint();

    paint.color = Colors.red;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      2 * pi,
      true,
      paint,
    );
    // Draw icon in Section 1
    drawIcon(canvas, center, radius, -pi / 3, Icons.local_police, 1);

    paint.color = Colors.green;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi / 3,
      2 * pi / 3,
      true,
      paint,
    );
    // Draw icon in Section 2
    drawIcon(canvas, center, radius, pi / 3, Icons.local_hospital, 2);

    paint.color = Colors.blue;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi,
      2 * pi / 3,
      true,
      paint,
    );
    // Draw icon in Section 3
    drawIcon(canvas, center, radius, -pi, Icons.fire_truck, 3);
  }

  void drawIcon(Canvas canvas, Offset center, double radius, double startAngle,
      IconData icon, int sectionNo) {
    final iconSize = radius * 0.4;
    dynamic iconOffset;
    if (sectionNo == 1) {
      iconOffset = Offset(
        center.dx + radius * cos(startAngle + pi / 3) / 2.5,
        center.dy + radius * sin(startAngle + pi / 3),
      );
    } else if (sectionNo == 2) {
      iconOffset = Offset(
        center.dx + radius * cos(startAngle + pi / 3),
        center.dy + radius * sin(startAngle + pi / 3) / 2.5,
      );
    } else if (sectionNo == 3) {
      iconOffset = Offset(
        center.dx + radius * cos(startAngle + pi / 3) / 1,
        center.dy + radius * sin(startAngle + pi / 3) / 1.2,
      );
    }

    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: iconSize,
          fontFamily: icon.fontFamily,
          color: Colors.white,
          /* This line is mandatory for external icon packs (eg. MaterialIcons or FontAwesome) */
          package: icon.fontPackage,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, iconOffset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Emergency extends StatefulWidget {
  const Emergency({super.key});

  @override
  EmergencyState createState() => EmergencyState();
}

class EmergencyState extends State<Emergency> {
  ApiService apiService = ApiService();
  PopupService popupService = PopupService();
  AuthService authService = AuthService();
  Settings settings = Settings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(isImplyLeading: false),
      body: Builder(
        builder: (innerContext) => GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! < 0) {
              Scaffold.of(innerContext).openDrawer();
            }
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Colors
                    .white), // must add this for the sidebar to open when swiped (?)
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Emergency',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900,
                              color: settings.emergencyTextColor2)),
                      const SizedBox(height: 30.0),
                      PizzaButton(
                        crimeEmergency: () {
                          // Handle Crime Emergency
                          authService.sendEmergencyChannel({
                            'token': authService.getAuthToken(),
                            'emergencyType': 'crime'
                          });
                        },
                        medicalEmergency: () {
                          // Handle Medical Emergency
                          authService.sendEmergencyChannel({
                            'token': authService.getAuthToken(),
                            'emergencyType': 'medical'
                          });
                        },
                        fireEmergency: () {
                          // Handle Fire Emergency
                          authService.sendEmergencyChannel({
                            'token': authService.getAuthToken(),
                            'emergencyType': 'fire'
                          });
                        },
                      ),
                      const SizedBox(height: 50.0),
                      FractionallySizedBox(
                          widthFactor: 0.8,
                          child: Text(
                              'After pressing the button, the requested personnel will be dispatched to your home address',
                              softWrap: true,
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: settings.emergencyTextColor2))),
                    ],
                  )),
            ),
          ),
        ),
      ),
      drawer: const LeftDrawer(),
      bottomNavigationBar: BottomNavBar(selectedIndex: 4),
    );
  }
}
