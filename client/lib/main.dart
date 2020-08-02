import 'package:Mike/screens/dashboard_screen.dart';
import 'package:Mike/screens/home_screen.dart';
import 'package:Mike/screens/login_screen.dart';
import 'package:Mike/screens/push_messaging_example.dart';
import 'package:flutter/material.dart';

import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: HomeScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        PushMessagingExample.id: (context) => PushMessagingExample(),
        DashboardScreen.id: (context) => DashboardScreen()
      },
    ),
  );
}
