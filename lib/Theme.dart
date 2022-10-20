import 'package:flutter/material.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:template/RatingView.dart';
import 'package:template/screens/home_screen.dart';

class AppTheme {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
      textTheme: GoogleFonts.oswald(
        headline2: const TextStyle(
          fontSize: 40,
          color: Colors.black,
        ),
        headline6: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        bodyText2: const TextStyle(
          fontSize: 22,
          color: Colors.black,
        ),
        button: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        fontSize: 25, //Ändra,,
      ),
      //      textTheme: GoogleFonts.oswald(fontSize: 20)(
      //        Theme.of(context).textTheme,
      //        ),

      primarySwatch: Colors.blueGrey,
      scaffoldBackgroundColor: const Color.fromARGB(255, 29, 29, 33),
      backgroundColor: const Color(
          0xFF27272D), //backgroundColor: const Color.fromARGB(255, 29, 29, 33),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),

      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 17,
      ),
      //    home: DefaultTabController(
      //      length:3,
      //      child: Scaffold(
      //        appBar: AppBar(
      //          bottom: TabBar(
      //            tabs: [
      //              Tab(text: "SSS",)
      //              Tab(text: "HHH",)
      //              Tab(text: "WWW",)
      //            ],
      //          ),
      //          //,,,
      //        ),
      //      ),
    ));
  }
}

class GoogleFonts {
  static oswald(
      {required int fontSize,
      required TextStyle headline2,
      required TextStyle headline6,
      required TextStyle bodyText2,
      required TextStyle button}) {}
}
