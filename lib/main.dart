import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/screens/home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    //FOR DARKMODE IN SYSTEM
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   systemNavigationBarColor: Color(0xFF27272D),
    //   systemNavigationBarIconBrightness: Brightness.dark,
    //   statusBarBrightness: Brightness.dark,
    // ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          scaffoldBackgroundColor: const Color.fromARGB(255, 29, 29, 33),
          fontFamily: 'Roboto',
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.white, displayColor: Colors.white)),
      home: const HomeScreen(),
    );
  }
}
