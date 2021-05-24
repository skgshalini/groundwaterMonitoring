import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
enum NavigationState {
  HOME,
  GRAPH,
  PROFILE,
}
NavigationState currentstate = NavigationState.HOME;
class NavigationBar extends StatefulWidget{
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {

  @override
    Widget build(BuildContext context) {
    // TODO: implement build
    child:GNav(
//rippleColor: Colors.grey[800],
        rippleColor: Colors.white,
        backgroundColor: Colors.black,
//  hoverColor: Colors.grey[700],
        hoverColor: Colors.blueAccent,
        haptic: true, // haptic feedback
        tabBorderRadius: 15,
        tabActiveBorder: Border.all(
            color: Colors.blueAccent, width: 1), // tab button border
        tabBorder: Border.all(
            color: Colors.blueAccent, width: 1), // tab button border
        tabShadow: [
          BoxShadow(color: Colors.purple.withOpacity(0.5), blurRadius: 8)
        ], // tab button shadow
        curve: Curves.easeOutExpo, // tab animation curves
        duration: Duration(milliseconds: 900), // tab animation duration
        gap: 8, // the tab button gap between icon and text
        color: Colors.purple, // unselected icon color
        activeColor: Colors.white, // selected icon and text color
        iconSize: 30, // tab button icon size
        tabBackgroundColor: Colors.blueAccent
            .withOpacity(0.1), // selected tab background color
        padding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 5), // navigation bar padding
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
            onPressed: () {
              setState(() {
                currentstate = NavigationState.HOME;
              });
            },
          ),
          GButton(
            icon: Icons.add_chart,
            text: 'Graphs',
            onPressed: () {
              setState(() {
                currentstate = NavigationState.GRAPH;
              });
            },
          ),
          GButton(
            icon: Icons.account_circle,
            text: 'Profile',
            onPressed: () {
              setState(() {
                currentstate = NavigationState.PROFILE;
              });
            },
          ),
//  GButton(
//    icon: Icons.settings,
//    text: 'Settings',
// ),
        ]);

  }
}