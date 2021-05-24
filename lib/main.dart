
import 'package:flutter/material.dart';
import 'package:groundwater_monitoring/screens/NavigationPage.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/NavigationPage.dart';

Future<void> main() async{

  runApp(GroundwaterMonitoring());}

class GroundwaterMonitoring extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        NavigationScreen.id:(context)=>NavigationScreen(),
      },
    );
  }
}
