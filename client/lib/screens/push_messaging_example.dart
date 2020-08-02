import 'package:Mike/components/rounded_button.dart';
import 'package:Mike/screens/dashboard_screen.dart';
import 'package:Mike/screens/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:Mike/services/networking.dart';

class PushMessagingExample extends StatefulWidget {
  static String id = 'push_messaging_example';

  @override
  _PushMessagingExampleState createState() => _PushMessagingExampleState();
}

class _PushMessagingExampleState extends State<PushMessagingExample> {
  String _homeScreenText = "Waiting for token...";
  String _messageText = "Waiting for message...";
  String myToken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((token) {
      assert(token != null);
      myToken = token;
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
      //Faccio la subscription su measurify
      Future<String> sub = NetworkHelper.makeSubscription(
          'http://students.atmosphere.tools/v1/subscriptions',
          myToken,
          'entryphone');
      print('Subscription fatta');
      Navigator.pushNamed(context, DashboardScreen.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View your entryphone'),
      ),
      body: Material(
        child: Column(
          children: <Widget>[
            Center(
              child: Text(_homeScreenText),
            ),
            Row(children: <Widget>[
              Expanded(
                child: Text(_messageText),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
