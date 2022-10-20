import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movie.dart';

class FilterList {
  static List<Movie> filterList(list, value) {
    if (value == 'All') return list;
    if (value == 'Action') {
      return list.where((movie) => movie.genreId[0] == 28).toList();
    }
    if (value == 'Adventure') {
      return list.where((movie) => movie.genreId[0] == 12).toList();
    }
    if (value == 'Animation') {
      return list.where((movie) => movie.genreId[0] == 16).toList();
    }
    if (value == 'Comedy') {
      return list.where((movie) => movie.genreId[0] == 35).toList();
    }
    if (value == 'Crime') {
      return list.where((movie) => movie.genreId[0] == 80).toList();
    }
    if (value == 'Documentary') {
      return list.where((movie) => movie.genreId[0] == 99).toList();
    }
    if (value == 'Drama') {
      return list.where((movie) => movie.genreId[0] == 18).toList();
    }
    if (value == 'Family') {
      return list.where((movie) => movie.genreId[0] == 10751).toList();
    }
    if (value == 'Fantasy') {
      return list.where((movie) => movie.genreId[0] == 14).toList();
    }
    if (value == 'History') {
      return list.where((movie) => movie.genreId[0] == 36).toList();
    }
    if (value == 'Horror') {
      return list.where((movie) => movie.genreId[0] == 27).toList();
    }
    if (value == 'Music') {
      return list.where((movie) => movie.genreId[0] == 10402).toList();
    }
    if (value == 'Mystery') {
      return list.where((movie) => movie.genreId[0] == 9648).toList();
    }
    if (value == 'Romance') {
      return list.where((movie) => movie.genreId[0] == 10749).toList();
    }
    if (value == 'Science Fiction') {
      return list.where((movie) => movie.genreId[0] == 878).toList();
    }
    if (value == 'TV Movie') {
      return list.where((movie) => movie.genreId[0] == 10770).toList();
    }
    if (value == 'Thriller') {
      return list.where((movie) => movie.genreId[0] == 53).toList();
    }

    if (value == 'War') {
      return list.where((movie) => movie.genreId[0] == 10752).toList();
    } else if (value == 'Western') {
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
        onSelected: (String value) {
          Provider.of<MyState>(context, listen: false).setFilterBy(value);
        },
        itemBuilder: (context) => const [
              PopupMenuItem(value: 'All', child: Text('All')),
              PopupMenuItem(value: 'Action', child: Text('Action')),
              PopupMenuItem(value: 'Adventure', child: Text('Adventure')),
              PopupMenuItem(value: 'Animation', child: Text('Animation')),
              PopupMenuItem(value: 'Comedy', child: Text('Comedy')),
              PopupMenuItem(value: 'Crime', child: Text('Crime')),
              PopupMenuItem(value: 'Documentary', child: Text('Documentary')),
              PopupMenuItem(value: 'Drama', child: Text('Drama')),
              PopupMenuItem(value: 'Family', child: Text('Family')),
              PopupMenuItem(value: 'Fantasy', child: Text('Fantasy')),
              PopupMenuItem(value: 'History', child: Text('History')),
              PopupMenuItem(value: 'Horror', child: Text('Horror')),
              PopupMenuItem(value: 'Music', child: Text('Music')),
              PopupMenuItem(value: 'Mystery', child: Text('Mystery')),
              PopupMenuItem(value: 'Romance', child: Text('Romance')),
              PopupMenuItem(
                  value: 'Science Fiction', child: Text('Science Fiction')),
              PopupMenuItem(value: 'TV Movie', child: Text('TV Movie')),
              PopupMenuItem(value: 'Thriller', child: Text('Thriller')),
              PopupMenuItem(value: 'War', child: Text('War')),
              PopupMenuItem(value: 'Western', child: Text('Western')),
            ]);
  }
}
