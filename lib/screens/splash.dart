import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    animationController = new AnimationController(
        duration: Duration(seconds: 3), vsync: this)
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacementNamed(context, '/login'); //routeDefaultLogin
        }
      });
    super.initState();
  }

  AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              return Container(
                width: size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromRGBO(52, 82, 118, 1),
                      Color.fromRGBO(64, 113, 135, 1)
                    ])),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: new TextSpan(children: [
                      new TextSpan(
                          text: 'Demo',
                          style: GoogleFonts.titilliumWeb(
                              textStyle: TextStyle(
                                  color: Colors.white, letterSpacing: .5),
                              fontSize: 30,
                              fontWeight: FontWeight.w700)),
                      new TextSpan(
                          text: 'App',
                          style: GoogleFonts.titilliumWeb(
                              textStyle: TextStyle(
                                  color: Colors.white, letterSpacing: .5),
                              fontSize: 30,
                              fontWeight: FontWeight.normal)),
                      new TextSpan(
                          text: ' .',
                          style: GoogleFonts.titilliumWeb(
                              textStyle: TextStyle(
                                  color: Color.fromRGBO(207, 139, 78, 1),
                                  letterSpacing: .5),
                              fontSize: 30,
                              fontWeight: FontWeight.w900)),
                    ]),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
