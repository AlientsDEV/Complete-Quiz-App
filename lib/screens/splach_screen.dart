import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/onboarding_screen.dart';




class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}


class SplashState extends State<Splash> {



  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 200), () {
      checkFirstSeen();
    });
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Loading...'),
      ),
    );
  }



  /*
    Check if the User see the Intro Screen or not
  */

    Future checkFirstSeen() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool _seen = (prefs.getBool('seen') ?? false);

      if (_seen) {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new HomeScreen()));
      } else {
        prefs.setBool('seen', true);
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new OnboardingScreen()));
      }
    }


}