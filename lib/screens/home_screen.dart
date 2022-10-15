import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/MovieDetails.dart';
import 'package:template/models/movie.dart';
import 'package:template/providers/home_screen_provider.dart';
import 'package:template/providers/search_provider.dart';
import 'package:template/widgets/shimmer_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  PageController pageController =
      PageController(viewportFraction: 0.5, initialPage: 2);
  int activeMove = 2;
  TextEditingController serachController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF27272D),
      body: Column(
        children: [
          Expanded(
            child: Consumer<HomeScreenStateProvider>(
              builder: (context, homeScreenValue, child) {
                if (homeScreenValue.loadingHomeScreen) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SingleChildScrollView(
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
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        Provider.of<SearchStateProvider>(
                                                context,
                                                listen: false)
                                            .disposeSerach();
                                        serachController.text = "";
                                      },
                                      icon: const Icon(Icons.close)),
                                  border: InputBorder.none,
                                  hintStyle:
                                      const TextStyle(color: Color(0xFF92929D)),
                                  fillColor: Colors.amber,
                                  prefixIcon: const Icon(Icons.search,
                                      color: Color(0xFF92929D)),
                                  hintText: "Serach"),
                              onChanged: (input) {
                                if (input.isEmpty) {
                                  Provider.of<SearchStateProvider>(context,
                                          listen: false)
                                      .disposeSerach();
                                } else {
                                  Provider.of<SearchStateProvider>(context,
                                          listen: false)
                                      .getSearchResult(input);
                                }
                              },
                            ),
                          ),
                        ),
                        Consumer<SearchStateProvider>(
                            // TODO HANDLE EMPTY SEARCHES, PADDING AND STYLING
                            builder: (context, searchValue, child) {
                          if (searchValue.isSearching) {
                            return const CircularProgressIndicator();
                          } else if (searchValue.serachHits != null) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: GridView.builder(
                                  itemCount: searchValue.serachHits!.length,
                                  itemBuilder: ((context, index) => moviePoster(
                                      searchValue.serachHits![index], true)),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  )),
                            );
                          }
                          return Column(
                            children: [
                              SizedBox(
                                height: 300,
                                child: PageView.builder(
                                    onPageChanged: (page) {
                                      setState(() {
                                        activeMove = page;
                                      });
                                    },
                                    pageSnapping: true,
                                    itemCount: 5,
                                    controller: pageController,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return moviePoster(
                                          homeScreenValue
                                              .nowPlayingMovies[index],
                                          index == activeMove);
                                    }),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (var i = 0; i < 5; i++)
                                    pageIndication(i == activeMove)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  movieRow(
                                      "Popular", homeScreenValue.popularMovies),
                                  movieRow("Top rated",
                                      homeScreenValue.topRatedMovies),
                                  movieRow("Upcoming",
                                      homeScreenValue.upComingMovies)
                                ],
                              )
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                );
              },
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...movies.map((movie) => moviePoster(movie, true))
                  ],
                ),
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
                builder: (con) =>
                    MovieDetails(state.movie))); //TODO PUSH TO CORRECT MOVIE
          },
          child: AnimatedContainer(
            width: 120,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            margin: EdgeInsets.all(active ? 0 : 15),
            child: AnimatedOpacity(
              opacity: active ? 1.0 : 0.2,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: movie.poster == null
                    ? Image.asset(
                        "./assets/temp_movie_poster/movieDefualt.jpeg")
                    : Image.network(
                        'https://image.tmdb.org/t/p/w500/${movie.poster}',
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const SizedBox(child: ShimmerLoader());
                        },
                      ),
              ),
            ),
          ),
        ),
      ),
    );
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
