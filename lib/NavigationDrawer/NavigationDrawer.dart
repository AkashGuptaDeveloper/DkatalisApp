import 'package:dkatalis/HomeScreen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dkatalis/GlobalComponent/GlobalColorCode/GlobalColorCode.dart';
import 'package:dkatalis/GlobalComponent/GlobalImagesURL/GlobalImagesURL.adrt.dart';
import 'package:dkatalis/GlobalComponent/GlobalFlag/GlobalFlag.dart';
import 'dart:async';
import 'dart:io';

//----------------NavigationDrawer---------------------------------------------//
class NavigationDrawer extends StatefulWidget {
  @override
  NavigationDrawerState createState() => new NavigationDrawerState();
}

//----------------------NavigationDrawerState----------------------------------//
class NavigationDrawerState extends State<NavigationDrawer> {
  // ignore: non_constant_identifier_names
  var ReciveJsonUSERFullName;
  // ignore: non_constant_identifier_names
  int ChangeColor;
//-----------------------------initState()-------------------------------------//
  @override
  void initState() {
    super.initState();
  }

//------------------------------dispose()--------------------------------------//
  @override
  void dispose() {
    super.dispose();
  }

//-------------------------------Widget----------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Drawer(
          elevation: 20.0,
          child: new Drawer(
              elevation: 20.0,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    child: UserAccountsDrawerHeader(
                      accountName: Text(
                        GlobalFlag.ReciveJsonUSERFullName.toString(),
                        style: TextStyle(
                          fontFamily: GlobalFlag.Raleway.toString(),
                          fontSize: 16,
                          color: ColorCode.WhiteColorCode,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      accountEmail: new Text(
                        GlobalFlag.UserEmail.toString(),
                        style: TextStyle(
                          fontFamily: GlobalFlag.Raleway.toString(),
                          fontSize: 16,
                          color: ColorCode.WhiteColorCode,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      currentAccountPicture: new CircleAvatar(
                        radius: 50.0,
                        backgroundColor: ColorCode.WhiteColorCode,
                        backgroundImage: AssetImage(
                            GlobalImagesURL.DeveloperImage.toString()),
                      ),
                    ),
                  ),
//-------------------------------------Home-----------------------------------//
                  Container(
                    color: ChangeColor == 1
                        ? ColorCode.AppColorCode
                        : ColorCode.WhiteColorCode,
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.home,
                            size: 20,
                            color: ChangeColor == 1
                                ? ColorCode.WhiteColorCode
                                : ColorCode.AppIcon,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            GlobalFlag.Home.toUpperCase(),
                            style: TextStyle(
                              fontFamily: GlobalFlag.Raleway.toString(),
                              fontSize: 14,
                              color: ChangeColor == 1
                                  ? ColorCode.WhiteColorCode
                                  : ColorCode.AppIcon,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        ChnageTapColorHome();
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(HomeScreen.tag);
                      },
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 0.2,
                    color: ColorCode.AppColorCode,
                  ),
//----------------------------------------------------moneyCheck--------------------------------------------------------------//
                  Container(
                    color: ChangeColor == 3
                        ? ColorCode.AppColorCode
                        : ColorCode.WhiteColorCode,
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.signOutAlt,
                            size: 20,
                            color: ChangeColor == 3
                                ? ColorCode.WhiteColorCode
                                : ColorCode.AppIcon,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            GlobalFlag.LogOut.toUpperCase(),
                            style: TextStyle(
                              fontFamily: GlobalFlag.Raleway.toString(),
                              fontSize: 14,
                              color: ChangeColor == 3
                                  ? ColorCode.WhiteColorCode
                                  : ColorCode.AppIcon,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        ChnageTapColorLogout();
                        Navigator.of(context).pop();
                        TapMessage(
                            context, GlobalFlag.ConfirmationMessage.toString());
                      },
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 0.2,
                    color: ColorCode.AppIcon,
                  ),
                ],
              )),
        ),
      ),
    );
  }

//--------------------Navigation-Color-Change---------------------------------//
  // ignore: non_constant_identifier_names
  void ChnageTapColorHome() {
    setState(() {
      ChangeColor = 1;
    });
  }

// ignore: non_constant_identifier_names
  void ChnageTapColorMockTest() {
    setState(() {
      ChangeColor = 2;
    });
  }

  // ignore: non_constant_identifier_names
  void ChnageTapColorLogout() {
    setState(() {
      ChangeColor = 3;
    });
  }

//-----------------------------TapMessage------------------------------------//
  // ignore: non_constant_identifier_names
  Future<void> TapMessage(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            message,
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontSize: 12.0,
                color: ColorCode.AppIcon,
                fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  GlobalFlag.LogOutApp.toString(),
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 12.0,
                      color: ColorCode.AppIcon,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                GlobalFlag.Cancel.toUpperCase(),
                style: new TextStyle(
                    fontSize: 12.0,
                    color: ColorCode.AppIcon,
                    fontWeight: FontWeight.bold),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                removeData(context);
              },
              child: Text(
                GlobalFlag.Ok.toString(),
                style: new TextStyle(
                    fontSize: 12.0,
                    color: ColorCode.AppIcon,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

//-------------------------removeData-----------------------------------------//
  removeData(BuildContext context) async {
    exit(0);
  }
}
//------------------------------END-------------------------------------------//
