import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/models/movie.dart';
import 'package:template/providers/home_screen_provider.dart';
import 'package:template/providers/search_provider.dart';
import 'package:template/widgets/movie_poster.dart';

class HomeScreen extends StatefulWidget {
  final TextEditingController serachController;
  const HomeScreen({required this.serachController, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  PageController pageController =
      PageController(viewportFraction: 0.5, initialPage: 2);
  int activeMove = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              controller: widget.serachController,
                              decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(top: 15),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        Provider.of<SearchStateProvider>(
                                                context,
                                                listen: false)
                                            .disposeSerach();
                                        widget.serachController.text = "";
                                      },
                                      icon: const Icon(Icons.close)),
                                  border: InputBorder.none,
                                  hintStyle:
                                      const TextStyle(color: Color(0xFF92929D)),
                                  prefixIcon: const Icon(Icons.search,
                                      color: Color(0xFF92929D), size: 20),
                                  hintText: "Search"),
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
                            builder: (context, searchValue, child) {
                          if (searchValue.isSearching) {
                            return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height / 3,
                                    horizontal:
                                        MediaQuery.of(context).size.width / 3),
                                child: const Center(
                                    child: CircularProgressIndicator()));
                          } else if (searchValue.serachHits != null &&
                              searchValue.serachHits!.isEmpty) {
                            return const Center(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 50),
                                    child: Text("No movies found")));
                          } else if (searchValue.serachHits != null) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.9,
                              child: GridView(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 1 / 1.4),
                                children: [
                                  ...searchValue.serachHits!.map((movie) =>
                                      MoviePoster(movie: movie, active: true)),
                                  for (int i = 0; i < 3; i++)
                                    Container(height: 50)
                                ],
                              ),
                            );
                          }
                          return Column(
                            children: [
                              SizedBox(
                                height: 280,
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
                                      return MoviePoster(
                                          movie: homeScreenValue
                                              .nowPlayingMovies[index],
                                          active: index == activeMove);
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
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 8),
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
                    ...movies
                        .map((movie) => MoviePoster(movie: movie, active: true))
                  ],
                ),
              ))
        ],
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
