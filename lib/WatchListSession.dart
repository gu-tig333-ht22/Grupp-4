// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:template/AddMovie.dart';
import 'package:template/AddWatchList.dart';

class WatchListSession extends StatefulWidget {
  const WatchListSession({super.key});

  @override
  State<WatchListSession> createState() => WatchListSessionState();
}

class WatchListSessionState extends State<WatchListSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.add, color: Colors.white, size: 30),
                tooltip: 'Add movie',
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddMovie())),
              )
            ],
            backgroundColor: Color(0xFF27272D),
            centerTitle: true,
            title: const Text(
              'My First Watchlist',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromARGB(255, 255, 255, 255)),
            )),
        body: Container(
            color: Color(0xFF27272D),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            alignment: AlignmentDirectional.topStart,
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset("./assets/spiderman.jpg",
                      width: 125, height: 125),
                  Image.asset("./assets/thor.jpeg", width: 125, height: 125),
                  Image.asset("./assets/spiderman.jpg",
                      width: 125, height: 125),
                  Image.asset("./assets/thor.jpeg", width: 125, height: 125),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("./assets/spiderman.jpg",
                        width: 125, height: 125),
                  ],
                )
              ],
            )));
  }
}
