import 'package:flutter/material.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:template/RatingView.dart';
import 'package:template/screens/home_screen.dart';

@override
Widget build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blueGrey,
      textTheme: GoogleFonts.oswald(fontSize: 17),
      scaffoldBackgroundColor: const Color.fromARGB(255, 29, 29, 33),
      backgroundColor: const Color.fromARGB(255, 29, 29, 33),
      fontFamily: 'Roboto',
      
    ),
  );
}
