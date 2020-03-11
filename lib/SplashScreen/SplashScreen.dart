import 'dart:async';
import 'package:dkatalis/HomeScreen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dkatalis/Animation/FadeAnimation.dart';
import 'package:dkatalis/GlobalComponent/NavigationRoute/NavigationRoute.dart';
import 'package:dkatalis/GlobalComponent/GlobalColorCode/GlobalColorCode.dart';
import 'package:dkatalis/GlobalComponent/GlobalImagesURL/GlobalImagesURL.adrt.dart';
import 'package:dkatalis/GlobalComponent/GlobalFlag/GlobalFlag.dart';
//--------------------START---------------------------------------------------//
class SplashScreen extends StatefulWidget {
  static String tag = NavigationRoute.TagSplashScreen.toString();
  @override
  SplashScreenState createState() => new SplashScreenState();
}
//----------------------------SplashScreenState-------------------------------//
class SplashScreenState extends State<SplashScreen> {
  void handleTimeout() async {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (_) => new HomeScreen()));
  }
//----------------------------------startTimeout------------------------------//
  startTimeout() async {
    var duration = const Duration(seconds: 2);
    return new Timer(duration, handleTimeout);
  }
//---------------------------------------initState-----------------------------//
  @override
  void initState() {
    super.initState();
    startTimeout();
  }
//------------------------------------Widget build-----------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.WhiteColorCode,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                GlobalImagesURL.AppLogo,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ],
      ),
//-------------------------------AppDeveloperName-----------------------------//
      bottomNavigationBar: FadeAnimation(
        1,
        Container(
          padding: EdgeInsets.only(bottom: 24.0),
          child: new Text(
            GlobalFlag.AppDeveloperName.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: GlobalFlag.Raleway.toString(),
            ),
          ),
        ),
      ),
    );
  }
}
//----------------------------------END----------------------------------------//
