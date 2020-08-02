import 'package:Mike/components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
              child: Text(
            'Mike',
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          )),
          SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: RoundedButton(
              backgroundColor: Colors.lightBlueAccent,
              text: 'Login',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
          )
        ],
      ),
    );
  }
}
