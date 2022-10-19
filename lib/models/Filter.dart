import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movie.dart';

class FilterList {
  static List<Movie> filterList(list, value) {
    if (value == 0) return list;
    if (value == 28) {
      return list.where((movie) => movie.genreId[0] == 28).toList();
    }
    if (value == 12) {
      return list.where((movie) => movie.genreId[0] == 12).toList();
    }
    if (value == 16) {
      return list.where((movie) => movie.genreId[0] == 16).toList();
    }
    if (value == 35) {
      return list.where((movie) => movie.genreId[0] == 35).toList();
    }
    if (value == 80) {
      return list.where((movie) => movie.genreId[0] == 80).toList();
    }
    if (value == 99) {
      return list.where((movie) => movie.genreId[0] == 99).toList();
    }
    if (value == 18) {
      return list.where((movie) => movie.genreId[0] == 18).toList();
    }
    if (value == 10751) {
      return list.where((movie) => movie.genreId[0] == 10751).toList();
    }
    if (value == 14) {
      return list.where((movie) => movie.genreId[0] == 14).toList();
    }
    if (value == 36) {
      return list.where((movie) => movie.genreId[0] == 36).toList();
    }
    if (value == 27) {
      return list.where((movie) => movie.genreId[0] == 27).toList();
    }
    if (value == 10402) {
      return list.where((movie) => movie.genreId[0] == 10402).toList();
    }
    if (value == 9648) {
      return list.where((movie) => movie.genreId[0] == 9648).toList();
    }
    if (value == 10749) {
      return list.where((movie) => movie.genreId[0] == 10749).toList();
    }
    if (value == 878) {
      return list.where((movie) => movie.genreId[0] == 878).toList();
    }
    if (value == 53) {
      return list.where((movie) => movie.genreId[0] == 53).toList();
    }
    if (value == 10752) {
      return list.where((movie) => movie.genreId[0] == 10752).toList();
    } else if (value == 37) {
      return list.where((movie) => movie.genreId[0] == 37).toList();
    }

    return list;
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: Colors.black,
        onSelected: (int genreId) {
          Provider.of<MyState>(context, listen: false).setFilterBy(genreId);
        },
        itemBuilder: (context) => [
              PopupMenuItem(child: Text('All'), value: 0),
              PopupMenuItem(child: Text('Action'), value: 28),
              PopupMenuItem(child: Text('Adventure'), value: 12),
              PopupMenuItem(child: Text('Animation'), value: 16),
              PopupMenuItem(child: Text('Comedy'), value: 35),
              PopupMenuItem(child: Text('Crime'), value: 80),
              PopupMenuItem(child: Text('Documentary'), value: 99),
              PopupMenuItem(child: Text('Drama'), value: 18),
              PopupMenuItem(child: Text('Family'), value: 10751),
              PopupMenuItem(child: Text('Fantasy'), value: 14),
              PopupMenuItem(child: Text('History'), value: 36),
              PopupMenuItem(child: Text('Horror'), value: 27),
              PopupMenuItem(child: Text('Music'), value: 10402),
              PopupMenuItem(child: Text('Mystery'), value: 9648),
              PopupMenuItem(child: Text('Romance'), value: 10749),
              PopupMenuItem(child: Text('Science Fiction'), value: 878),
              PopupMenuItem(child: Text('TV Moive'), value: 10770),
              PopupMenuItem(child: Text('Thriller'), value: 53),
              PopupMenuItem(child: Text('War'), value: 10752),
              PopupMenuItem(child: Text('Western'), value: 37),
            ]);
  }
}
