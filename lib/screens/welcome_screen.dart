import 'package:firebase_auth/firebase_auth.dart';
import 'package:groundwater_monitoring/components/RoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:groundwater_monitoring/screens/login_screen.dart';
import 'NavigationPage.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Image.asset('images/water.png'),
                  height: 100.0,
                ),
                TextLiquidFill(
                  text: 'Groundwater Monitoring',
                  textStyle: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            RoundedButton(
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, NavigationScreen.id);
                    } else
                      Navigator.pushNamed(context, LoginScreen.id);
                  });
                },
                colour: Colors.black,
                title: 'Log In'),
          ],
        ),
      ),
    );
  }
}
