import 'package:flutter/material.dart';
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
                padding: const EdgeInsets.fromLTRB(0,55,0,15),
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
                            prefixIcon: Icon(Icons.search, color: Color(0xFF92929D)),
                            hintText: "Serach"
                          ),
                          onChanged: (_) {}, //TODO POPULATE SEARCH LIST AND UPDATE UI
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
                          return moviePoster(movies[index], index == activeMove);
                        }
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...movies.asMap().entries.map((e) => pageIndication(e.key == activeMove))
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
      //bottomNavigationBar: bottomNavTabBar()//bottomNavBar(),
    );
  }

  // Widget bottomNavBar() {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       boxShadow: [BoxShadow(
  //           color: Color(0xFF27272D),
  //           blurRadius: 10,
  //           spreadRadius: 15,
  //         )]
  //     ),
  //     height: 55,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: const [
  //         Icon(Icons.home),
  //         Icon(Icons.list),
  //         Icon(Icons.favorite)
  //       ],
  //     ),
  //   );
  // }

  
  //  Widget bottomNavTabBar() {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       boxShadow: [BoxShadow(
  //           color: Color(0xFF27272D),
  //           blurRadius: 10,
  //           spreadRadius: 15,
  //         )]
  //     ),
  //     height: 55,
  //     child: TabBar(
  //       indicator: const PointTabIndicator(
  //         position: PointTabIndicatorPosition.bottom,
  //         color: Color(0xFF0296E5),
  //         insets: EdgeInsets.only(bottom: 10)
  //       ),
  //       controller: TabController(length: 3, vsync: this),
  //       tabs: const [
  //         Tab(icon: Icon(Icons.home, color: Colors.black)),
  //         Tab(icon: Icon(Icons.list, color: Colors.black)),
  //         Tab(icon: Icon(Icons.favorite, color: Colors.black))
  //       ],
  //     ),
  //   );
  // }



  Widget movieRow(String title, List<Movie> movies) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...movies.map((movie) => moviePoster(movie, true))
              ],
            )
          )
        ],
      ),
    );
  }

  Widget moviePoster(Movie movie, bool active) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {}, //TODO ROUTE TO MOVIE PAGE
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
      )
    );
  }

  Widget pageIndication(bool active) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            color: active ?const Color(0xFF0296E5) : const Color(0xFF3F3F44),
            blurRadius: active ? 5 : 0,
            spreadRadius: active ? 5 : 0,
          )],
          borderRadius: BorderRadius.circular(15),
          color: active ?const Color(0xFF0296E5) : const Color(0xFF3F3F44),),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        height: 6,
        width: active ? 20 : 6,
        ),
    );
  }

}

final List<Movie> movies = [
  const Movie(id: "1", poster: "assets/temp_movie_poster/test.jpeg", title: "Mortal Combat"),
  const Movie(id: "1", poster: "assets/temp_movie_poster/test2.jpeg", title: "Ant Man"),
  const Movie(id: "1", poster: "assets/temp_movie_poster/test3.jpeg", title: "Tenet"),
  const Movie(id: "1", poster: "assets/temp_movie_poster/test4.jpeg", title: "6 Underground"),
];

class Movie {
  final String poster;
  final String id;
  final String title;

  const Movie({required this.id, required this.poster, required this.title});
}