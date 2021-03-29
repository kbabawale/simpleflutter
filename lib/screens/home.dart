import 'package:demo/screens/homeNews.dart';
import 'package:demo/screens/politicsNews.dart';
import 'package:demo/screens/sportsNews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username;
  int selectedIndex = 0;

  List<dynamic> widgets = [
    {
      'title': 'Top News',
      'widget': HomeNews(),
    },
    {'title': 'Sports News', 'widget': SportsNews()},
    {'title': 'Business News', 'widget': PoliticsNews()}
  ];

  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("loggedin", false);
    Navigator.of(context).popAndPushNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    dynamic arguments = ModalRoute.of(context).settings.arguments;
    if (arguments == null) Navigator.of(context).pop();

    setState(() {
      username = arguments["username"];
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widgets[selectedIndex]['title']),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            tooltip: 'Logout',
            onPressed: () {
              _logout();
            },
          ),
        ],
      ),
      body: Container(
        child: widgets[selectedIndex]['widget'],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_soccer), label: 'Sports'),
          BottomNavigationBarItem(icon: Icon(Icons.gavel), label: 'Business'),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
