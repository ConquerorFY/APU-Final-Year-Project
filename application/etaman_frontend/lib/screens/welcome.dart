import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  WelcomeState createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.green.withOpacity(0.6),
            BlendMode.srcATop,
          ),
          child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/neighborhood.png'),
                      fit: BoxFit.cover))),
        ),
        Container(
          color: const Color.fromRGBO(0, 0, 0,
              0.6), // Replace '0.5' with the desired opacity value (0.0 to 1.0)
        ),
        SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                    width: 250,
                    height: 250,
                    // Add any other custom image settings you need
                  ),
                ),
                const SizedBox(height: 5),
                const Text('eTaman',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        fontFamily: "OpenSans",
                        color: Colors.white)),
                const SizedBox(height: 10),
                const FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Center(
                        child: Text(
                            '~ Connect, Share, and Unite in Your Neighborhood! ~',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontFamily: "OpenSans",
                                color: Colors.white)))),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Login Screen
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green.shade400),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(20))),
                  child: const Text('Login As User',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: "OpenSans",
                          color: Colors.white)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Register Screen
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red.shade400),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(20))),
                  child: const Text('Register As User',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: "OpenSans",
                          color: Colors.white)),
                ),
              ],
            ))
      ],
    ));
  }
}
