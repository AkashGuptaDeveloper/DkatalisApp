import 'package:dkatalis/HomeScreen/HomeScreen.dart';
import 'package:dkatalis/SplashScreen/SplashScreen.dart';
import 'package:flutter/material.dart';

final routes = {
  '/Splash': (BuildContext context) => new SplashScreen(),
  '/': (BuildContext context) => new SplashScreen(),
  SplashScreen.tag: (context) => SplashScreen(),
  HomeScreen.tag: (context) => HomeScreen(),
};
