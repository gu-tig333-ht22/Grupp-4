import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/MovieDetails.dart';
import 'package:template/models/movie.dart';
// import 'package:flutter_point_tab_bar/pointTabIndicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  PageController pageController = PageController(viewportFraction: 0.5);
  int activeMove = 0;
  TextEditingController serachController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF27272D),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 76, 76, 82),
                        ),
                        child: TextField(
                          controller: serachController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Color(0xFF92929D)),
                              fillColor: Colors.amber,
                              prefixIcon:
                                  Icon(Icons.search, color: Color(0xFF92929D)),
                              hintText: "Serach"),
                          onChanged:
                              (_) {}, //TODO POPULATE SEARCH LIST AND UPDATE UI
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: PageView.builder(
                          onPageChanged: (page) {
                            setState(() {
                              activeMove = page;
                            });
                          },
                          pageSnapping: true,
                          itemCount: movies.length,
                          controller: pageController,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return moviePoster(
                                movies[index], index == activeMove);
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...movies
                            .asMap()
                            .entries
                            .map((e) => pageIndication(e.key == activeMove))
                      ],
                    ),
                    movieRow("Nyheter", movies),
                    movieRow("Topplistan", movies),
                    movieRow("Komedi", movies),
                    movieRow("Barnfilmer", movies)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget movieRow(String title, List<Movie> movies) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [...movies.map((movie) => moviePoster(movie, true))],
              ))
        ],
      ),
    );
  }

  Widget moviePoster(Movie movie, bool active) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<MyState>(
            builder: (context, state, child) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (con) => MovieDetails(state.movie)));
                  }, //TODO ROUTE TO MOVIE PAGE
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutCubic,
                    margin: EdgeInsets.all(active ? 0 : 15),
                    child: AnimatedOpacity(
                      opacity: active ? 1.0 : 0.2,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(movie.poster)),
                    ),
                  ),
                )));
  }

  Widget pageIndication(bool active) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: active ? const Color(0xFF0296E5) : const Color(0xFF3F3F44),
              blurRadius: active ? 5 : 0,
              spreadRadius: active ? 5 : 0,
            )
          ],
          borderRadius: BorderRadius.circular(15),
          color: active ? const Color(0xFF0296E5) : const Color(0xFF3F3F44),
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        height: 6,
        width: active ? 20 : 6,
      ),
    );
  }
}

final List<Movie> movies = [
  const Movie(
      id: 1,
      poster: "assets/temp_movie_poster/test.jpeg",
      title: "Mortal Combat",
      overview: '',
      rating: 1,
      runTime: 12,
      genre: ''),
  const Movie(
      id: 1,
      poster: "assets/temp_movie_poster/test2.jpeg",
      title: "Ant Man",
      overview: '',
      rating: 1,
      runTime: 12,
      genre: ''),
  const Movie(
      id: 1,
      poster: "assets/temp_movie_poster/test3.jpeg",
      title: "Tenet",
      overview: '',
      rating: 1,
      runTime: 12,
      genre: ''),
  const Movie(
      id: 1,
      poster: "assets/temp_movie_poster/test4.jpeg",
      title: "6 Underground",
      overview: '',
      rating: 1,
      runTime: 12,
      genre: ''),
];
