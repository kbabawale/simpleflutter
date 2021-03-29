import 'package:demo/screens/home.dart';
import 'package:demo/screens/homeNews.dart';
import 'package:demo/screens/login.dart';
import 'package:demo/screens/politicsNews.dart';
import 'package:demo/screens/splash.dart';
import 'package:demo/screens/sportsNews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/home-news':
        return MaterialPageRoute(builder: (_) => HomeNews());
      case '/sports-news':
        return MaterialPageRoute(builder: (_) => SportsNews());
      case '/politics-news':
        return MaterialPageRoute(builder: (_) => PoliticsNews());
      case '/home':
        return MaterialPageRoute(
            builder: (_) => HomePage(), settings: settings);
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
