import 'dart:convert';

import 'package:Mike/components/reusable_card.dart';
import 'package:Mike/services/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:video_player/video_player.dart';
import 'package:Mike/services/networking.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DashboardScreen extends StatefulWidget {
  static String id = "dashboard_screen";
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool mute = true;
  bool audio = false;

  String initialUrl;

  void getMicAudio() {
    try {
      askMicPermission();
    } catch (e) {
      print("Error: Permission not granted!");
      print(e);
    }
  }

  void askMicPermission() async {
    var status = await Permission.microphone.status;
    if (status.isGranted)
      return;
    else if (status.isDenied || status.isPermanentlyDenied) {
      //TODO: ask to reopen (button che {openAppSettings();}) and change the permission
      print("mic permission denied or permanentlyDenied");
      throw Error();
    } else if (status.isRestricted) {
      //TODO: tell the user so
      print("mic permission restricted");
      throw new Error();
    } else if (await Permission.microphone.request().isGranted) {
      print("microphone permission granted");
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    String url = 'http://students.atmosphere.tools/v1/measurements/';
    //String measurement = '5f15719b59060e445c877cc5';
    Future<String> measurement = NetworkHelper.getMeasurementID(
        url, NetworkHelper.authToken, "entryphone");
    String file = '/file?Authorization=';
    String token = NetworkHelper.authToken;
    measurement.then((value) {
      String meas = value;
      Map<String, dynamic> jsonDecoded = jsonDecode(meas);
      meas = jsonDecoded['docs'][0]['_id'];
      initialUrl = url + meas + file + token;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: WebView(
              //initialUrl: initialUrl,
              initialUrl:
                  'http://students.atmosphere.tools/v1/measurements/5f199ce500591977408c45ae/file?Authorization=' +
                      NetworkHelper.authToken,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundIconButton(
                  icon: mute
                      ? FontAwesomeIcons.microphoneSlash
                      : FontAwesomeIcons.microphone,
                  onPressed: () {
                    setState(() {
                      mute = !mute;
                      if (!mute) getMicAudio();
                    });
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                RoundIconButton(
                  icon: audio
                      ? FontAwesomeIcons.volumeUp
                      : FontAwesomeIcons.volumeOff,
                  onPressed: () {
                    setState(() {
                      audio = !audio;
                    });
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                RoundIconButton(
                  onPressed: () async {
                    print('here');
                    String result = await NetworkHelper.postALockMeasurement();
                    print(result);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: result == "1"
                              ? new Text("Door Opened")
                              : new Text("Error"),
                          // content: new Text("Check your login information"),
                        );
                      },
                    );
                  },
                  icon: FontAwesomeIcons.key,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, @required this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      onPressed: onPressed,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        width: 65,
        height: 65,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}
