import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dkatalis/NavigationDrawer/NavigationDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dkatalis/GlobalComponent/NavigationRoute/NavigationRoute.dart';
import 'package:dkatalis/GlobalComponent/GlobalColorCode/GlobalColorCode.dart';
import 'package:dkatalis/GlobalComponent/GlobalServiceURl/GlobalServiceURl.dart';
import 'package:dkatalis/GlobalComponent/GlobalFlag/GlobalFlag.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dkatalis/DBHelper/DbStudentManager.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:swipedetector/swipedetector.dart';
//---------------------------------START--------------------------------------//
class HomeScreen extends StatefulWidget {
  static String tag = NavigationRoute.TagHomeScreen.toString();
  @override
  HomeScreenState createState() => new HomeScreenState();
}
//--------------------------------HomeScreenState-----------------------------//
class HomeScreenState extends State<HomeScreen> {
  // ignore: non_constant_identifier_names
  String UserList_ServiceUrl = GlobalServiceURl.BaseURL.toString();
  String status = '';
  String errMessage = GlobalFlag.ErrorSendData.toString();
  var dataCategory;
  ScrollController _scrollController = new ScrollController();
  // ignore: non_constant_identifier_names
  ProgressDialog pr;
  // ignore: non_constant_identifier_names
  var ExtractJsonData;
  // ignore: non_constant_identifier_names
  var ExtractArrayData;
  // ignore: non_constant_identifier_names
  var ExtractDataFromUser;
  // ignore: non_constant_identifier_names
  var UserTitle;
  // ignore: non_constant_identifier_names
  var UserFirst;
  // ignore: non_constant_identifier_names
  var UserLast;
  // ignore: non_constant_identifier_names
  var UserGender;
  // ignore: non_constant_identifier_names
  var Location;
  // ignore: non_constant_identifier_names
  var City;
  // ignore: non_constant_identifier_names
  var State;
  // ignore: non_constant_identifier_names
  var Zip;
  // ignore: non_constant_identifier_names
  var Email;
  // ignore: non_constant_identifier_names
  var Username;
  // ignore: non_constant_identifier_names
  var Password;
  // ignore: non_constant_identifier_names
  var Salt;
  // ignore: non_constant_identifier_names
  var Dob;
  // ignore: non_constant_identifier_names
  var Phone;
  // ignore: non_constant_identifier_names
  var Cell;
  // ignore: non_constant_identifier_names
  var SSN;
  // ignore: non_constant_identifier_names
  var Picture;
  // ignore: non_constant_identifier_names
  var FullName;
  // ignore: non_constant_identifier_names
  var MyAddress;
  // ignore: non_constant_identifier_names
  var ReciveObject;
  Employee student;
  List<Employee> studlist;
  final DbStudentManager dbmanager = new DbStudentManager();
//----------------------------_checkInternetConnectivity----------------------//
  void _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog(GlobalFlag.NoInternet, GlobalFlag.InternetNotConnected);
    }
  }
//---------------------------initState()--------------------------------------//
  @override
  void initState() {
    this._checkInternetConnectivity();
    super.initState();
    this.fetchUserList();
  }
//-----------------------------dispose()--------------------------------------//
  @override
  void dispose() {
    super.dispose();
  }
//-----------------------Widget build-----------------------------------------//
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
      message: GlobalFlag.PleaseWait.toString(),
    );
//------------------------------------WillPopScope----------------------------//
    return new WillPopScope(
      onWillPop: () => BackScreen(),
      child: Scaffold(
        drawer: _drawer(),
        appBar: new AppBar(
          backgroundColor: ColorCode.AppColorCode,
          iconTheme: new IconThemeData(color: Colors.white),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                GlobalFlag.Home.toString().toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: GlobalFlag.Raleway.toString(),
                  fontSize: 16,
                  color: ColorCode.WhiteColorCode,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                GlobalFlag.ReciveJsonUSERFullName.toString().toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: GlobalFlag.Raleway.toString(),
                  fontSize: 16,
                  color: ColorCode.WhiteColorCode,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[200],
//-----------------------------Body-ShowList-----------------------------------//
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SwipeDetector(
                          child: Card(
                            margin: new EdgeInsets.all(25),
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 0.0,
                                bottom:0.0,
                                left: 6.0,
                                right: 6.0,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Center(
                                    child: CircularProfileAvatar(
                                      Picture.toString().trim(),
                                      radius:
                                      60, // sets radius, default 50.0
                                      backgroundColor: ColorCode
                                          .AppColorCode, // sets background color, default Colors.white
                                      cacheImage:
                                      true, // allow widget to cache image against provided url
                                      showInitialTextAbovePicture:
                                      true, // setting it true will show initials text above profile picture, default false
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  new Text(
                                    GlobalFlag.Address.toString(),
                                    style: TextStyle(
                                      fontFamily:
                                      GlobalFlag.Raleway.toString(),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  new Center(
                                    child: Text(
                                      MyAddress == null
                                          ? GlobalFlag.Wait.toString()
                                          : MyAddress.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily:
                                        GlobalFlag.Raleway.toString(),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  new Container(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: FlatButton(
                                            onPressed: () {
                                              UserDetailsDialog(UserTitle,
                                                  UserFirst, UserLast);
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: Column(
                                              // Replace with a Row for horizontal icon + text
                                              children: <Widget>[
                                                Icon(FontAwesomeIcons.user),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: FlatButton(
                                            onPressed: () {
                                              UserEmailDetailsDialog(Email);
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: Column(
                                              // Replace with a Row for horizontal icon + text
                                              children: <Widget>[
                                                Icon(FontAwesomeIcons
                                                    .envelope),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: FlatButton(
                                            onPressed: () {
                                              UserLocationDetailsDialog(
                                                  City, State, Zip);
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: Column(
                                              // Replace with a Row for horizontal icon + text
                                              children: <Widget>[
                                                Icon(FontAwesomeIcons.map),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: FlatButton(
                                            onPressed: () {
                                              UserCallDetailsDialog(
                                                  Phone, Cell, SSN);
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: Column(
                                              // Replace with a Row for horizontal icon + text
                                              children: <Widget>[
                                                Icon(
                                                    FontAwesomeIcons.phone),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: FlatButton(
                                            onPressed: () {
                                              UserPasswordDetailsDialog(
                                                  Password);
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            child: Column(
                                              // Replace with a Row for horizontal icon + text
                                              children: <Widget>[
                                                Icon(FontAwesomeIcons.lock),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onSwipeLeft: () {
                            setState(() {
                              pr.show();
                              fetchUserList();
                              print(GlobalFlag.SwipeRight.toString());
                            });
                          },
                          onSwipeRight: () {
                            setState(() {
                              pr.show();
                              fetchUserList();
                              print(GlobalFlag.SwipeLeft.toString());
                              _submitStudent(context, UserFirst, UserLast);
                            });
                          },
                          swipeConfiguration: SwipeConfiguration(
                              verticalSwipeMinVelocity: 100.0,
                              verticalSwipeMinDisplacement: 50.0,
                              verticalSwipeMaxWidthThreshold:100.0,
                              horizontalSwipeMaxHeightThreshold: 50.0,
                              horizontalSwipeMinDisplacement:50.0,
                              horizontalSwipeMinVelocity: 200.0),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 50,
                  color: ColorCode.AppColorCode,
                  child: new FlatButton.icon(
                    //color: Colors.red,
                    icon: Icon(
                      FontAwesomeIcons.heart,
                      color: const Color(0xFFFFFFFF),
                    ), //`Icon` to display
                    label: Text(GlobalFlag.MyFavorite.toUpperCase(),
                        style: TextStyle(
                          fontSize: 15.0,
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                        )), //`Text` to display
                    onPressed: () {
                      setState(() {
                        UserDisplayFavDialog(context);
                      });
                    },
                  ),
                ),
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
//-----------------------------------------AlertDialog------------------------//
  Future<void> _showDialog(title, text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            GlobalFlag.InternetWarning,
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontSize: 15.0,
                color: ColorCode.AppIcon,
                fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  title.toString(),
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
                _dismissDialog();
                Navigator.of(context);
              },
              child: Text(
                GlobalFlag.Ok.toString(),
                style: new TextStyle(
                    fontSize: 15.0,
                    color: ColorCode.AppIcon,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
//-------------------------------_dismissDialog-------------------------------//
  _dismissDialog() {
    Navigator.pop(context);
  }
//----------------------------Widget _drawer----------------------------------//
  Widget _drawer() {
    return new Drawer(
      elevation: 20.0,
      child: NavigationDrawer(),
    );
  }
//-------------------------------------------------_onBackPressed-------------//
  // ignore: non_constant_identifier_names
  Future<bool> BackScreen() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              GlobalFlag.Areyousure.toString(),
              style: TextStyle(
                  color: ColorCode.AppIcon,
                  fontFamily: GlobalFlag.Raleway.toString(),
                  fontSize: 14.0),
            ),
            content: new Text(
              GlobalFlag.exitanApp.toString(),
              style: TextStyle(
                  color: ColorCode.AppIcon,
                  fontFamily: GlobalFlag.Raleway.toString(),
                  fontSize: 14.0),
            ),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: roundedButton(
                  GlobalFlag.No.toString(),
                  const Color(0xFFFD9E32),
                  const Color(0xFFFFFFFF),
                ),
              ),
              new GestureDetector(
                onTap: () => exit(0),
                child: roundedButton(GlobalFlag.Yes.toString(),
                    const Color(0xFFFD9E32), const Color(0xFFFFFFFF)),
              ),
            ],
          ),
        ) ??
        false;
  }
//---------------------------------------roundedButton------------------------//
  Widget roundedButton(String buttonLabel, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      padding: EdgeInsets.all(5.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFFFFFFFF),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }
//--------------------------fetchUserList--------------------------------------//
  Future<void> fetchUserList() async {
    try {
      // ignore: non_constant_identifier_names
      final ResultFromServer = await http.get(UserList_ServiceUrl.toString());
      if (ResultFromServer.statusCode == 200) {
        ExtractJsonData = jsonDecode(ResultFromServer.body);
        ExtractArrayData =
            ExtractJsonData[GlobalFlag.JsonArrayresultsKey.toString()];
        ExtractDataFromUser =
            ExtractArrayData[0][GlobalFlag.JsonArrayuserKey.toString()];
        setState(() {
          UserGender =
              ExtractDataFromUser[GlobalFlag.JsonUsergender.toString()];
          UserTitle = ExtractDataFromUser[GlobalFlag.JsonUserName.toString()]
              [GlobalFlag.JsonUsertitle.toString()];
          UserFirst = ExtractDataFromUser[GlobalFlag.JsonUserName.toString()]
              [GlobalFlag.JsonUserfirst.toString()];
          UserLast = ExtractDataFromUser[GlobalFlag.JsonUserName.toString()]
              [GlobalFlag.JsonUserlast.toString()];
          Location = ExtractDataFromUser[GlobalFlag.Jsonlocation.toString()]
              [GlobalFlag.JsonUserstreet.toString()];
          City = ExtractDataFromUser[GlobalFlag.Jsonlocation.toString()]
              [GlobalFlag.JsonUsercity.toString()];
          State = ExtractDataFromUser[GlobalFlag.Jsonlocation.toString()]
              [GlobalFlag.JsonUserstate.toString()];
          Zip = ExtractDataFromUser[GlobalFlag.Jsonlocation.toString()]
              [GlobalFlag.JsonUserzip.toString()];
          Email = ExtractDataFromUser[GlobalFlag.JsonUseremail.toString()];
          Username =
              ExtractDataFromUser[GlobalFlag.JsonUserusername.toString()];
          Password =
              ExtractDataFromUser[GlobalFlag.JsonUseruserpassword.toString()];
          Salt = ExtractDataFromUser[GlobalFlag.JsonUserusersalt.toString()];
          Dob = ExtractDataFromUser[GlobalFlag.JsonUserusedob.toString()];
          Phone = ExtractDataFromUser[GlobalFlag.JsonUserusephone.toString()];
          Cell = ExtractDataFromUser[GlobalFlag.JsonUserusecell.toString()];
          SSN = ExtractDataFromUser[GlobalFlag.JsonUseruseSSN.toString()];
          Picture =
              ExtractDataFromUser[GlobalFlag.JsonUserusepicture.toString()];
          FullName = UserTitle +
              " " +
              UserFirst.toString() +
              " " +
              UserLast.toString();
          MyAddress = City + " " + State.toString() + " " + Zip.toString();
        });
        pr.hide();
      }
    } catch (e) {
      print(e);
    }
  }
//--------------------------------setStatus------------------------------------//
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
//-------------------------------UserDetailsDialog---------------------------//
// ignore: non_constant_identifier_names
  Future<void> UserDetailsDialog(UserTitle, UserFirst, UserLast) async {
    setState(() {
      // ignore: unnecessary_statements
      UserTitle;
      // ignore: unnecessary_statements
      UserFirst;
      // ignore: unnecessary_statements
      UserLast;
    });
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            GlobalFlag.UserDetails.toString(),
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 15.0,
              color: ColorCode.AppColorCode,
              fontWeight: FontWeight.bold,
              fontFamily: GlobalFlag.Raleway.toString(),
            ),
          ),
          content: new ListView(
            controller: _scrollController,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Row(children: [
                    new Container(
                      child: new Text(
                        GlobalFlag.Title.toString(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontWeight: FontWeight.bold,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 5.0),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    new Container(
                      child: new Text(
                        UserTitle.toString().toUpperCase(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(right: 5.0),
                    ),
                  ]),
                ],
              ),
              Divider(thickness: 0.2, color: ColorCode.AppIcon),
              SizedBox(
                height: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Row(children: [
                    new Container(
                      child: new Text(
                        GlobalFlag.FirstName.toString(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontWeight: FontWeight.bold,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 5.0),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    new Container(
                      child: new Text(
                        UserFirst.toString().toUpperCase(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontFamily: GlobalFlag.Raleway.toString(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      margin: const EdgeInsets.only(right: 5.0),
                    ),
                  ]),
                ],
              ),
              Divider(thickness: 0.2, color: ColorCode.AppIcon),
              SizedBox(
                height: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Row(children: [
                    new Container(
                      child: new Text(
                        GlobalFlag.UserLast.toString(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontWeight: FontWeight.bold,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 5.0),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    new Container(
                      child: new Text(
                        UserLast.toString().toUpperCase(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontFamily: GlobalFlag.Raleway.toString(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      margin: const EdgeInsets.only(right: 5.0),
                    ),
                  ]),
                ],
              ),
              Divider(thickness: 0.2, color: ColorCode.AppIcon),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: new FlatButton.icon(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: ColorCode.AppColorCode)),
                  color: ColorCode.AppColorCode,
                  icon: Icon(
                    FontAwesomeIcons.thumbsUp,
                    color: ColorCode.WhiteColorCode,
                    size: 15.0,
                  ), //`Icon` to display
                  label: Text(GlobalFlag.Ok.toString(),
                      style: new TextStyle(
                        fontSize: 12.0,
                        color: ColorCode.WhiteColorCode,
                        fontWeight: FontWeight.bold,
                        fontFamily: GlobalFlag.Raleway.toString(),
                      )), //`Text` to display
                  onPressed: () {
                    Navigator.of(context).pop();
                    //ChatClass
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
//-------------------------------UserDetailsDialog---------------------------//
// ignore: non_constant_identifier_names
  Future<void> UserEmailDetailsDialog(Email) async {
    setState(() {
      // ignore: unnecessary_statements
      Email;
    });
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            GlobalFlag.UserDetailsDob.toString(),
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 15.0,
              color: ColorCode.AppColorCode,
              fontWeight: FontWeight.bold,
              fontFamily: GlobalFlag.Raleway.toString(),
            ),
          ),
          content: new ListView(
            controller: _scrollController,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Column(children: [
                    new Container(
                      child: new Text(
                        GlobalFlag.Emails.toString(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontWeight: FontWeight.bold,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 0.0),
                    ),
                    new Container(
                      child: new Text(
                        Email.toString(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 5.0),
                    ),
                  ]),
                ],
              ),
              Divider(thickness: 0.2, color: ColorCode.AppIcon),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: new FlatButton.icon(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: ColorCode.AppColorCode)),
                  color: ColorCode.AppColorCode,
                  icon: Icon(
                    FontAwesomeIcons.thumbsUp,
                    color: ColorCode.WhiteColorCode,
                    size: 15.0,
                  ), //`Icon` to display
                  label: Text(GlobalFlag.Ok.toString(),
                      style: new TextStyle(
                        fontSize: 12.0,
                        color: ColorCode.WhiteColorCode,
                        fontWeight: FontWeight.bold,
                        fontFamily: GlobalFlag.Raleway.toString(),
                      )), //`Text` to display
                  onPressed: () {
                    Navigator.of(context).pop();
                    //ChatClass
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
//-------------------------------UserDetailsDialog---------------------------//
// ignore: non_constant_identifier_names
  Future<void> UserLocationDetailsDialog(City, State, Zip) async {
    setState(() {
      // ignore: unnecessary_statements
      City;
      // ignore: unnecessary_statements
      State;
      // ignore: unnecessary_statements
      Zip;
    });
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            GlobalFlag.UserDetailsLocation.toString(),
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 15.0,
              color: ColorCode.AppColorCode,
              fontWeight: FontWeight.bold,
              fontFamily: GlobalFlag.Raleway.toString(),
            ),
          ),
          content: new ListView(
            controller: _scrollController,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Row(children: [
                    new Container(
                      child: new Text(
                        GlobalFlag.City.toString(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontWeight: FontWeight.bold,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 5.0),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    new Container(
                      child: new Text(
                        City.toString().toUpperCase(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(right: 5.0),
                    ),
                  ]),
                ],
              ),
              Divider(thickness: 0.2, color: ColorCode.AppIcon),
              SizedBox(
                height: 10.0,
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Row(children: [
                    new Container(
                      child: new Text(
                        GlobalFlag.State.toString(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontWeight: FontWeight.bold,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 5.0),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    new Container(
                      child: new Text(
                        State.toString().toUpperCase(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(right: 5.0),
                    ),
                  ]),
                ],
              ),
              Divider(thickness: 0.2, color: ColorCode.AppIcon),
              SizedBox(
                height: 10.0,
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Row(children: [
                    new Container(
                      child: new Text(
                        GlobalFlag.Zip.toString(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontWeight: FontWeight.bold,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 5.0),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    new Container(
                      child: new Text(
                        Zip.toString().toUpperCase(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(right: 5.0),
                    ),
                  ]),
                ],
              ),
              Divider(thickness: 0.2, color: ColorCode.AppIcon),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: new FlatButton.icon(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: ColorCode.AppColorCode)),
                  color: ColorCode.AppColorCode,
                  icon: Icon(
                    FontAwesomeIcons.thumbsUp,
                    color: ColorCode.WhiteColorCode,
                    size: 15.0,
                  ), //`Icon` to display
                  label: Text(GlobalFlag.Ok.toString(),
                      style: new TextStyle(
                        fontSize: 12.0,
                        color: ColorCode.WhiteColorCode,
                        fontWeight: FontWeight.bold,
                        fontFamily: GlobalFlag.Raleway.toString(),
                      )), //`Text` to display
                  onPressed: () {
                    Navigator.of(context).pop();
                    //ChatClass
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
//-------------------------------UserDetailsDialog---------------------------//
// ignore: non_constant_identifier_names
  Future<void> UserCallDetailsDialog(Phone, Cell, SSN) async {
    setState(() {
      // ignore: unnecessary_statements
      Phone;
      Cell;
      SSN;
    });
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            GlobalFlag.UserDetailsCall.toString(),
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 15.0,
              color: ColorCode.AppColorCode,
              fontWeight: FontWeight.bold,
              fontFamily: GlobalFlag.Raleway.toString(),
            ),
          ),
          content: new ListView(
            controller: _scrollController,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Row(children: [
                    new Container(
                      child: new Text(
                        GlobalFlag.Phone.toString(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontWeight: FontWeight.bold,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 5.0),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    new Container(
                      child: new Text(
                        Phone.toString().toUpperCase(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(right: 5.0),
                    ),
                  ]),
                ],
              ),
              Divider(thickness: 0.2, color: ColorCode.AppIcon),
              SizedBox(
                height: 10.0,
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Row(children: [
                    new Container(
                      child: new Text(
                        GlobalFlag.Cell.toString(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontWeight: FontWeight.bold,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 5.0),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    new Container(
                      child: new Text(
                        Cell.toString().toUpperCase(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(right: 5.0),
                    ),
                  ]),
                ],
              ),
              Divider(thickness: 0.2, color: ColorCode.AppIcon),
              SizedBox(
                height: 10.0,
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Row(children: [
                    new Container(
                      child: new Text(
                        GlobalFlag.SSN.toString(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontWeight: FontWeight.bold,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 5.0),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    new Container(
                      child: new Text(
                        SSN.toString().toUpperCase(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(right: 5.0),
                    ),
                  ]),
                ],
              ),
              Divider(thickness: 0.2, color: ColorCode.AppIcon),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: new FlatButton.icon(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: ColorCode.AppColorCode)),
                  color: ColorCode.AppColorCode,
                  icon: Icon(
                    FontAwesomeIcons.thumbsUp,
                    color: ColorCode.WhiteColorCode,
                    size: 15.0,
                  ), //`Icon` to display
                  label: Text(GlobalFlag.Ok.toString(),
                      style: new TextStyle(
                        fontSize: 12.0,
                        color: ColorCode.WhiteColorCode,
                        fontWeight: FontWeight.bold,
                        fontFamily: GlobalFlag.Raleway.toString(),
                      )), //`Text` to display
                  onPressed: () {
                    Navigator.of(context).pop();
                    //ChatClass
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
//------------------------------UserDetailsDialog---------------------------//
// ignore: non_constant_identifier_names
  Future<void> UserPasswordDetailsDialog(Password) async {
    setState(() {
      // ignore: unnecessary_statements
      Password;
    });
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            GlobalFlag.UserDetailsPassword.toString(),
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 15.0,
              color: ColorCode.AppColorCode,
              fontWeight: FontWeight.bold,
              fontFamily: GlobalFlag.Raleway.toString(),
            ),
          ),
          content: new ListView(
            controller: _scrollController,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Row(children: [
                    new Container(
                      child: new Text(
                        GlobalFlag.Password.toString(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontWeight: FontWeight.bold,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 5.0),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    new Container(
                      child: new Text(
                        Password.toString().toUpperCase(),
                        style: new TextStyle(
                          fontSize: 15.0,
                          color: ColorCode.AppIcon,
                          fontFamily: GlobalFlag.Raleway.toString(),
                        ),
                      ),
                      margin: const EdgeInsets.only(right: 5.0),
                    ),
                  ]),
                ],
              ),
              Divider(thickness: 0.2, color: ColorCode.AppIcon),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: new FlatButton.icon(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: ColorCode.AppColorCode)),
                  color: ColorCode.AppColorCode,
                  icon: Icon(
                    FontAwesomeIcons.thumbsUp,
                    color: ColorCode.WhiteColorCode,
                    size: 15.0,
                  ), //`Icon` to display
                  label: Text(GlobalFlag.Ok.toString(),
                      style: new TextStyle(
                        fontSize: 12.0,
                        color: ColorCode.WhiteColorCode,
                        fontWeight: FontWeight.bold,
                        fontFamily: GlobalFlag.Raleway.toString(),
                      )), //`Text` to display
                  onPressed: () {
                    Navigator.of(context).pop();
                    //ChatClass
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
//-------------------------------UserDetailsDialog---------------------------//
// Save data to database
  // ignore: non_constant_identifier_names
  void _submitStudent(BuildContext context, UserFirst, UserLast) {
    Employee st = new Employee(name: UserFirst, course: UserLast);
    dbmanager
        .insertStudent(st)
        .then((id) => {print('Employee Added to Db ${id}')});
  }
//---------------------------UserDisplayFavDialog----------------------------//
  // ignore: non_constant_identifier_names
  Future<void> UserDisplayFavDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            GlobalFlag.MyFavorite.toString(),
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 15.0,
              color: ColorCode.AppColorCode,
              fontWeight: FontWeight.bold,
              fontFamily: GlobalFlag.Raleway.toString(),
            ),
          ),
          content: new FutureBuilder(
            future: dbmanager.getStudentList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                studlist = snapshot.data;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: studlist == null ? 0 : studlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    Employee st = studlist[index];
                    return Card(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'FirstName: ${st.name}',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  'LastName: ${st.course}',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return new CircularProgressIndicator();
            },
          ),
          actions: <Widget>[],
        );
      },
    );
  }
}
//---------------------END----------------------------------------------------//
