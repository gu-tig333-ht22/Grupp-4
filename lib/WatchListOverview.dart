// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:html';

import 'package:flutter/material.dart';
import 'main.dart';
import 'package:provider/provider.dart';

class WatchListOverview extends StatefulWidget {
  const WatchListOverview({super.key});

  @override
  State<WatchListOverview> createState() => WatchListOverviewState();
}

class WatchListOverviewState extends State<WatchListOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
          actions: [
            IconButton(
                icon: Icon(Icons.add, color: Colors.white, size: 30),
                tooltip: 'Create watchlist',
                onPressed: () {})
          ],
          backgroundColor: Color.fromARGB(255, 43, 42, 42),
          centerTitle: true,
          title: const Text(
            'My Watchlists',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 255, 255, 255)),
          )),
      body: Container(
        color: Color.fromARGB(255, 63, 62, 62),
        padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
        alignment: AlignmentDirectional.topStart,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  height: 12,
                  child: Text('My First Watchlist',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 255, 255, 255)))),
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(90, 212, 209, 209)))),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  height: 75,
                  child: Row(
                    children: [
                      Icon(Icons.movie, size: 36),
                      Icon(Icons.movie, size: 36),
                      Icon(Icons.movie, size: 36),
                      Icon(Icons.movie, size: 36),
                      Icon(Icons.movie, size: 36),
                      Icon(Icons.movie, size: 36),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  height: 12,
                  child: Text('My Second Watchlist',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 255, 255, 255)))),
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(90, 212, 209, 209)))),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  height: 75,
                  child: Row(
                    children: [
                      Icon(Icons.movie, size: 36),
                      Icon(Icons.movie, size: 36),
                      Icon(Icons.movie, size: 36),
                      Icon(Icons.movie, size: 36),
                      Icon(Icons.movie, size: 36),
                      Icon(Icons.movie, size: 36),
                    ],
                  )),
            ]),
      ),
    );
  }
}
