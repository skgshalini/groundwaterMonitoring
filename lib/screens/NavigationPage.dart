import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groundwater_monitoring/components/Navigation%20bar.dart';
import 'package:groundwater_monitoring/screens/Profile.dart';
import 'package:groundwater_monitoring/screens/welcome_screen.dart';
import 'data_input_screen.dart';
import 'graph.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:groundwater_monitoring/datacontroller/datafetch.dart';

const _url = 'http://rutag.iitd.ac.in/rutag/?q=ground-water-level-measuring-device';
class NavigationScreen extends StatefulWidget {
  static String id = 'navigation_screen';
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

void _launchURL() async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  String phone;
  void initState() {
    // TODO: implement initState
   phone= getPhone();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Groundwater Monitoring"),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: SafeArea(
          child: Container(
            color: Colors.black,
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,

              children: <Widget>[
                Container(
                  height: 60,
                  padding: EdgeInsets.fromLTRB(8, 15, 8, 8),
                  child: Text(
                    'Groundwater Monitoring',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(height: 0, thickness: 1, color: Colors.purple),
                ListTile(
                  title: Text(
                    'About',
                    style: TextStyle(fontSize: 18, color: Colors.purple),
                  ),

                  onTap: _launchURL,
                  // Update the state of the app.
                  // ...
                ),
                Divider(height: 0, thickness: 1, color: Colors.purple),
                ListTile(
                  title: Text('Logout',
                      style: TextStyle(fontSize: 18, color: Colors.purple)),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    Future<void> _signOut() async {
                      await FirebaseAuth.instance.signOut();
                    }

                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, WelcomeScreen.id);
                  },
                ),
                Divider(height: 0, thickness: 1, color: Colors.purple),
              ],
            ),
          ),
        ),
      ),
      //backgroundColor: Colors.blueAccent,
      body: SafeArea(
          child: Column(children: <Widget>[
       NavigationBar(),
        Expanded(
            child: currentstate == NavigationState.HOME
                ? dataInputScreen()
                : currentstate == NavigationState.GRAPH
                    ? Graph()
                    : Profile(phone))
      ])),
    );
    }
  }

