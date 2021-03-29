import 'package:demo/Util/network.dart';
import 'package:demo/model/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeNews extends StatefulWidget {
  @override
  _HomeNewsState createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  Future<List<News>> getData;

  @override
  void initState() {
    super.initState();

    getData = getFeed('general', language: 'en');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getData,
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasData) {
                  List<News> news = snapshot.data;

                  return ListView(
                    children: news
                        .map((News n) => Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(n.category.toUpperCase(),
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  38, 76, 120, 1),
                                              letterSpacing: -0.2),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500)),
                                  Text(n.description,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  38, 76, 120, 1),
                                              letterSpacing: -0.2),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                  Text(n.name,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.teal,
                                              letterSpacing: -0.2),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500)),
                                  Divider(
                                    thickness: 1.3,
                                    color: Color.fromRGBO(38, 76, 120, 1),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  );
                } else if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                }
            }
          }),
    );
  }
}
