// ignore_for_file: prefer_const_constructors

import 'dart:html';

import 'package:flutter/material.dart';
import 'main.dart';

class AddWatchList extends StatefulWidget {
  const AddWatchList({super.key});

  @override
  State<AddWatchList> createState() => AddWatchListState();
}

class AddWatchListState extends State<AddWatchList> {
  TextEditingController itemController = TextEditingController();
  TextEditingController filmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
          backgroundColor: Color.fromARGB(255, 43, 42, 42),
          centerTitle: true,
          title: const Text(
            'Create watchlist',
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
              TextField(
                  controller: itemController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      fillColor: Colors.white,
                      labelText: 'Enter list name...',
                      labelStyle: TextStyle(
                        color: Colors.grey[500],
                      ))),
              TextField(
                  controller: filmController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      fillColor: Colors.white,
                      labelText: 'Enter the name of a movie...',
                      labelStyle: TextStyle(
                        color: Colors.grey[500],
                      )))
            ]),
      ),
    );
  }
}
