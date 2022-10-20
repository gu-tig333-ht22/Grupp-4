import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movie.dart';

class FilterList {
  static List<Movie> filterList(list, value) {
    if (value == 0) return list;

    List<Movie> returnMovies = [];

    for (Movie movie in list) {
      if (movie.genreId!.contains(value)) returnMovies.add(movie);
    }

    return returnMovies;
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
              PopupMenuItem(value: 878, child: Text('Science Fiction')),
              PopupMenuItem(value: 10770, child: Text('TV Movie')),
              PopupMenuItem(value: 53, child: Text('Thriller')),
              PopupMenuItem(value: 10752, child: Text('War')),
              PopupMenuItem(value: 37, child: Text('Western')),
            ]);
  }
}

class MenuButtonTwo extends StatelessWidget {
  const MenuButtonTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: Colors.black,
        onSelected: (int value) {
          Provider.of<MyState>(context, listen: false)
              .setWatchListFilterBy(value);
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
              PopupMenuItem(value: 878, child: Text('Science Fiction')),
              PopupMenuItem(value: 10770, child: Text('TV Movie')),
              PopupMenuItem(value: 53, child: Text('Thriller')),
              PopupMenuItem(value: 10752, child: Text('War')),
              PopupMenuItem(value: 37, child: Text('Western')),
            ]);
  }
}

class GenreListMap {
  static Map genreMap = {
    0: 'All',
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentary',
    18: 'Drama',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Science Fiction',
    10770: 'TV Movie',
    53: 'Thriller',
    10752: 'War',
    37: 'Western'
  };
}
