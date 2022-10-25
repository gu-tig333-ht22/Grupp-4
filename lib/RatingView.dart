import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'MovieDetails.dart';
import 'models/movie.dart';
import 'models/Filter.dart';

class RatingView extends StatelessWidget {
  const RatingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            "My Ratings",
          ),
        ),
        backgroundColor: Color(0xFF27272D),
      ),
      body: Consumer<MyState>(builder: (context, state, child) {
        if (state.ratedMovies.isEmpty) {
          return Center(child: Text("You have not rated any movies yet."));
        }
        if (FilterList.filterList(state.ratedMovies, state.filterBy).isEmpty) {
          return Center(
            child: Text("You have no favorite movies of this genre"),
          );
        } else {
          return _ratingList(
              FilterList.filterList(state.ratedMovies, state.filterBy), state);
        }
      }),
    );
  }

  Widget _ratingList(rateList, state) {
    var list = List.generate(rateList.length, (index) => rateList[index]);

    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      itemCount: rateList.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            _item(list[index], context, state),
            const Divider(height: 10, thickness: 1),
          ],
        );
      },
    );
  }

  Widget _item(movie, context, state) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (con) => MovieDetails(movie.id)));
      },
      child: ListTile(
        visualDensity: VisualDensity(vertical: 4),
        leading: _image(movie.poster),
        title: Text(
          movie.title,
          style: TextStyle(fontSize: 20),
        ),
        trailing: RatingBar.builder(
          //unratedColor: Color.fromARGB(255, 29, 29, 33),
          itemSize: 28,
          initialRating: movieInRatedMovies(state.ratedMovies, movie) != null
              ? movieInRatedMovies(state.ratedMovies, movie) / 2
              : 0,
          minRating: 0.5,
          maxRating: 10,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.white,
          ),
          onRatingUpdate: (rating) {
            Provider.of<MyState>(context, listen: false)
                .postRating(movie.id, rating * 2);
          },
        ),
      ),
    );
  }

  Widget _image(poster) {
    return Container(
      height: 90,
      width: 50,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: poster != null
              ? NetworkImage('https://image.tmdb.org/t/p/w500/$poster')
              : Image.asset('./assets/temp_movie_poster/movieDefualt.jpeg')
                  as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  double movieInRatedMovies(list, movie) {
    for (var i = 0; i < list.length; i++) {
      if (movie.id == list[i].id) {
        double value = list[i].ownRating;
        return value;
      }
    }
    return 0;
  }
}
