import 'package:Mike/components/rounded_button.dart';
import 'package:Mike/screens/dashboard_screen.dart';
import 'package:Mike/screens/push_messaging_example.dart';
import 'package:Mike/services/networking.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Username',
                ),
                onChanged: (value) {
                  username = value;
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                obscureText: false, //TODO: make it true
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Password',
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 50,
              ),
              RoundedButton(
                backgroundColor: Colors.lightBlue,
                text: 'Log In',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    var token = await NetworkHelper.getToken(
                        'http://students.atmosphere.tools/v1/login',
                        username,
                        password);
                    print('Token: ' + token);
                    // NetworkHelper.test();
                    if (token == '0') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            title: new Text("Wrong Password"),
                            content: new Text("Check your login information"),
                            actions: <Widget>[
                              // usually buttons at the bottom of the dialog
                              new FlatButton(
                                child: new Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushNamed(context, LoginScreen.id);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      String _homeScreenText = "Waiting for token...";
                      final FirebaseMessaging _firebaseMessaging =
                          FirebaseMessaging();

                      _firebaseMessaging.configure(
                        onMessage: (Map<String, dynamic> message) async {
                          print("onMessage: $message");
                        },
                        onLaunch: (Map<String, dynamic> message) async {
                          print("onLaunch: $message");
                        },
                        onResume: (Map<String, dynamic> message) async {
                          print("onResume: $message");
                        },
                      );
                      _firebaseMessaging.requestNotificationPermissions(
                          const IosNotificationSettings(
                              sound: true, badge: true, alert: true));

                      _firebaseMessaging.onIosSettingsRegistered
                          .listen((IosNotificationSettings settings) {
                        print("Settings registered: $settings");
                      });

                      _firebaseMessaging.getToken().then((pushMessagingToken) {
                        // assert(pushMessagingToken != null);
                        print(pushMessagingToken);
                        _homeScreenText =
                            "Push Messaging token: $pushMessagingToken";
                        print(_homeScreenText);
                        //Faccio la subscription su measurify
                        Future<String> sub = NetworkHelper.makeSubscription(
                            'http://students.atmosphere.tools/v1/subscriptions',
                            pushMessagingToken,
                            'entryphone');
                        print('Subscription fatta');
                        Navigator.pushNamed(context, DashboardScreen.id);
                      });

                      // Navigator.pushNamed(context, PushMessagingExample.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

const kTextFieldDecoration = InputDecoration(
  hintText: 'hint text',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  //TODO: make the background color white
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
