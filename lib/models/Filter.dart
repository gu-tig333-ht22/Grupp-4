import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movie.dart';

class FilterList {
  static List<Movie> filterList(list, value) {

    if(value == 0) return list;
    
    List<Movie> returnMovies = [];

    for(Movie movie in list) {
      if (movie.genreId!.contains(value)) returnMovies.add(movie);
    }

    return returnMovies;

    // if (value == 'All') return list;
    // if (value == 'Action') {
    //   return list.where((movie) => movie.genreId[0] == 28).toList();
    // }
    // if (value == 'Adventure') {
    //   return list.where((movie) => movie.genreId[0] == 12).toList();
    // }
    // if (value == 'Animation') {
    //   return list.where((movie) => movie.genreId[0] == 16).toList();
    // }
    // if (value == 'Comedy') {
    //   return list.where((movie) => movie.genreId[0] == 35).toList();
    // }
    // if (value == 'Crime') {
    //   return list.where((movie) => movie.genreId[0] == 80).toList();
    // }
    // if (value == 'Documentary') {
    //   return list.where((movie) => movie.genreId[0] == 99).toList();
    // }
    // if (value == 'Drama') {
    //   return list.where((movie) => movie.genreId[0] == 18).toList();
    // }
    // if (value == 'Family') {
    //   return list.where((movie) => movie.genreId[0] == 10751).toList();
    // }
    // if (value == 'Fantasy') {
    //   return list.where((movie) => movie.genreId[0] == 14).toList();
    // }
    // if (value == 'History') {
    //   return list.where((movie) => movie.genreId[0] == 36).toList();
    // }
    // if (value == 'Horror') {
    //   return list.where((movie) => movie.genreId[0] == 27).toList();
    // }
    // if (value == 'Music') {
    //   return list.where((movie) => movie.genreId[0] == 10402).toList();
    // }
    // if (value == 'Mystery') {
    //   return list.where((movie) => movie.genreId[0] == 9648).toList();
    // }
    // if (value == 'Romance') {
    //   return list.where((movie) => movie.genreId[0] == 10749).toList();
    // }
    // if (value == 'Science Fiction') {
    //   return list.where((movie) => movie.genreId[0] == 878).toList();
    // }
    // if (value == 'TV Movie') {
    //   return list.where((movie) => movie.genreId[0] == 10770).toList();
    // }
    // if (value == 'Thriller') {
    //   return list.where((movie) => movie.genreId[0] == 53).toList();
    // }

    // if (value == 'War') {
    //   return list.where((movie) => movie.genreId[0] == 10752).toList();
    // } else if (value == 'Western') {
    //   return list.where((movie) => movie.genreId[0] == 37).toList();
    // }

    // return list;
  }




}

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: Colors.black,
        onSelected: (int value) {
          Provider.of<MyState>(context, listen: false).setFilterBy(value);
        },
        itemBuilder: (context) => const [
              PopupMenuItem(value: 0, child: Text('All')),
              PopupMenuItem(value: 28, child: Text('Action')),
              PopupMenuItem(value: 12, child: Text('Adventure')),
              PopupMenuItem(value: 16, child: Text('Animation')),
              PopupMenuItem(value: 35, child: Text('Comedy')),
              PopupMenuItem(value: 80, child: Text('Crime')),
              PopupMenuItem(value: 99, child: Text('Documentary')),
              PopupMenuItem(value: 18, child: Text('Drama')),
              PopupMenuItem(value: 10751, child: Text('Family')),
              PopupMenuItem(value: 14, child: Text('Fantasy')),
              PopupMenuItem(value: 36, child: Text('History')),
              PopupMenuItem(value: 27, child: Text('Horror')),
              PopupMenuItem(value: 10402, child: Text('Music')),
              PopupMenuItem(value: 9648, child: Text('Mystery')),
              PopupMenuItem(value: 10749, child: Text('Romance')),
              PopupMenuItem(
                  value: 878, child: Text('Science Fiction')),
              PopupMenuItem(value: 10770, child: Text('TV Movie')),
              PopupMenuItem(value: 53, child: Text('Thriller')),
              PopupMenuItem(value: 10752, child: Text('War')),
              PopupMenuItem(value: 37, child: Text('Western')),
            ]);
  }
}
