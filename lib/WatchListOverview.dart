// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:template/AddWatchList.dart';
import 'package:template/WatchListSession.dart';
import 'package:template/models/Filter.dart';

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
          actions: [
            MenuButton(),
            IconButton(
              icon: Icon(Icons.add, color: Colors.white, size: 30),
              tooltip: 'Create watchlist',
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => AddWatchList())),
            )
          ],
          backgroundColor: Color(0xFF27272D),
          centerTitle: true,
          title: const Text(
            'My Watchlists',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 255, 255, 255)),
          )),
      body: Container(
        color: Color(0xFF27272D),
        padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
        alignment: AlignmentDirectional.topStart,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => WatchListSession())),
                child: Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    height: 12,
                    child: Text('My First Watchlist',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 255, 255, 255)))),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => WatchListSession())),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(90, 212, 209, 209)))),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    height: 75,
                    child: Row(
                      children: [
                        Image.asset("./assets/spiderman.jpg"),
                        Image.asset("./assets/thor.jpeg"),
                        Image.asset("./assets/spiderman.jpg"),
                        Image.asset("./assets/thor.jpeg"),
                        Image.asset("./assets/spiderman.jpg"),
                      ],
                    )),
              ),
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
                      Image.asset("./assets/spiderman.jpg"),
                      Image.asset("./assets/thor.jpeg"),
                    ],
                  )),
            ]),
      ),
    );
  }
}
