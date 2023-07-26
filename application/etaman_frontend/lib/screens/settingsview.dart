import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  SettingsViewState createState() => SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
  Settings settings = Settings();

  Map<String, Color> themeColors = {
    "blue": Colors.blue,
    "green": Colors.green,
    "orange": Colors.orange,
    "black": Colors.black,
    "indigo": Colors.indigo,
    "purple": Colors.purple,
    "pink": Colors.pink,
  };
  late Color selectedTheme;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedTheme = themeColors[settings.getThemeData()]!;
    });
  }

  List<Widget> createThemeColorList() {
    List<Widget> widgetsList = [];
    List<String> themeColorsKeys = themeColors.keys.toList();
    for (int i = 0; i < themeColorsKeys.length; i++) {
      String colorKey = themeColorsKeys[i];
      widgetsList.add(GestureDetector(
        onTap: () {
          // Set selected color
          setState(() {
            selectedTheme = themeColors[colorKey]!;
          });
          settings.writeThemeData(colorKey);
          settings.applyThemeData();
        },
        child: Container(
          margin: const EdgeInsets.all(8.0),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: themeColors[colorKey],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selectedTheme == themeColors[colorKey]
                  ? Colors.black
                  : Colors.transparent,
              width: 2,
            ),
          ),
        ),
      ));
    }
    return widgetsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Icon(Icons.settings, color: settings.settingsTopNavBarTextColor),
            const SizedBox(width: 15.0),
            const Text('Settings',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w900,
                )),
          ]),
          backgroundColor: settings.settingsTopNavBarBgColor,
          foregroundColor: settings.settingsTopNavBarTextColor,
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Column(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  const SizedBox(width: 10.0),
                  Text("Application Theme",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'OpenSans',
                        color: settings.settingsTextColor,
                        decoration: TextDecoration.underline,
                        decorationColor: settings.settingsTextColor,
                        decorationThickness: 3.0,
                      ))
                ]),
                const SizedBox(height: 8.0),
                Wrap(children: createThemeColorList()),
              ]),
            ])));
  }
}
