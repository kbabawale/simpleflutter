import 'package:demo/widgets/addSpacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool loggedinData;
  String loggedinDataUser;
  bool loader;
  bool formError;

  //get loggedin checker
  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool dataIn = prefs.getBool("loggedin") ?? false;
    String dataIn2 = prefs.getString("loggedinUsername") ?? '';
    setState(() {
      loggedinData = dataIn;
      loggedinDataUser = dataIn2;
    });
  }

  processLogin() async {
    setState(() {
      loader = true;
    });

    //validate form values
    if (_userNameController.value.text.toString().trim() != '' &&
        _passwordController.value.text.toString().trim() != '') {
      await Future.delayed(Duration(seconds: 3));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("loggedin", true);
      prefs.setString(
          "loggedinUsername", _userNameController.value.text.toString().trim());
      setState(() {
        loader = false;
        formError = false;
      });
      Navigator.of(context).popAndPushNamed('/home', arguments: {
        "username": _userNameController.value.text.toString().trim()
      });
    } else {
      setState(() {
        loader = true;
      });
      await Future.delayed(Duration(seconds: 3));
      setState(() {
        loader = false;
        formError = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      loader = false;
      formError = false;
      loggedinData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    setState(() {
      loader = true;
    });
    getData();
    if (loggedinData == true) {
      print('Already LoggedIn');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).popAndPushNamed('/home',
            arguments: {"username": loggedinDataUser});
      });
    }
    setState(() {
      loader = false;
    });

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          body: SingleChildScrollView(
              child: Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.teal)),
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(50),
                Container(
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.blueAccent)),
                  child: InkWell(
                    onTap: () {
                      print('hello');
                    },
                    child: Icon(Ionicons.ios_arrow_back,
                        size: 30, color: Color.fromRGBO(38, 76, 120, 1)),
                  ),
                ),
                addVerticalSpace(30),
                Text('Welcome,',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Color.fromRGBO(38, 76, 120, 1),
                            letterSpacing: -0.2),
                        fontSize: 30,
                        fontWeight: FontWeight.w500)),
                addVerticalSpace(2),
                Text('Sign in to continue',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            letterSpacing: -0.2),
                        fontSize: 15,
                        fontWeight: FontWeight.w400)),
                addVerticalSpace(40),
                TextField(
                  controller: _userNameController,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Color.fromRGBO(153, 153, 153, 1),
                          letterSpacing: -0.2),
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      fillColor: Color.fromRGBO(0, 0, 0, 0),
                      filled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            width: 1.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            width: 1.2),
                      ),
                      border: InputBorder.none,
                      hintText: 'Username'),
                  keyboardType: TextInputType.text,
                ),
                addVerticalSpace(25),
                TextField(
                  controller: _passwordController,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Color.fromRGBO(153, 153, 153, 1),
                          letterSpacing: -0.2),
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      fillColor: Color.fromRGBO(0, 0, 0, 0),
                      filled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            width: 1.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            width: 1.2),
                      ),
                      border: InputBorder.none,
                      hintText: 'Password'),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
                addVerticalSpace(20),
                Container(
                  child: formError
                      ? Text('Invalid Credentials',
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.red, letterSpacing: -0.2),
                              fontSize: 13,
                              fontWeight: FontWeight.w400))
                      : Text(''),
                ),
                addVerticalSpace(70),
                Material(
                  child: InkWell(
                    onTap: () {
                      processLogin();
                    },
                    child: Container(
                      width: size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(64, 113, 135, 1),
                                Color.fromRGBO(52, 82, 118, 1)
                              ])),
                      child: Text(
                        'Sign in',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.white, letterSpacing: -0.2),
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                addVerticalSpace(20),
                loader ? CircularProgressIndicator() : Text('')
                // Container(
                //     child: loader ? CircularProgressIndicator() : Text(''),
                //     alignment: Alignment.center)
              ],
            ),
          )),
        ));
  }
}
