import 'package:flutter/material.dart';
import 'package:dkatalis/routes.dart';
import 'package:flutter/services.dart';
import 'package:dkatalis/GlobalComponent/GlobalColorCode/GlobalColorCode.dart';
//-----------------------------START------------------------------------------//
void main() => runApp(new MyApp());
Map<int, Color> color = {
  50: Color.fromRGBO(253, 158, 50, .1),
  100: Color.fromRGBO(253, 158, 50, .2),
  200: Color.fromRGBO(253, 158, 50, .3),
  300: Color.fromRGBO(253, 158, 50, .4),
  400: Color.fromRGBO(253, 158, 50, .5),
  500: Color.fromRGBO(253, 158, 50, .6),
  600: Color.fromRGBO(253, 158, 50, .7),
  700: Color.fromRGBO(253, 158, 50, .8),
  800: Color.fromRGBO(253, 158, 50, .9),
  900: Color.fromRGBO(253, 158, 50, 10),
};

//-----------------------------------Class-MyApp-------------------------------//
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: ColorCode.AppColorCode));
    MaterialColor colorCustom = MaterialColor(0xFFFD9E32, color);
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: colorCustom,
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}
//-------------------------End------------------------------------------------//
