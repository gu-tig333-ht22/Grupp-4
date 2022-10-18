// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:template/providers/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:template/widgets/shimmer_loader.dart';
import 'package:template/MovieDetails.dart';
import 'package:template/models/movie.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({super.key});

  @override
  State<AddMovie> createState() => AddMovieState();
}

class AddMovieState extends State<AddMovie> {
  TextEditingController filmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
          backgroundColor: Color(0xFF27272D),
          centerTitle: true,
          title: const Text(
            'Add movie',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 255, 255, 255)),
          )),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFF27272D),
          padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
          alignment: AlignmentDirectional.topStart,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: filmController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          Provider.of<SearchStateProvider>(context,
                                  listen: false)
                              .disposeSerach();
                          filmController.text = "";
                        },
                        icon: const Icon(Icons.close)),
                    border: InputBorder.none,
                    hintStyle: const TextStyle(color: Color(0xFF92929D)),
                    fillColor: Colors.amber,
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xFF92929D)),
                    hintText: "Enter the name of a movie..."),
                onChanged: (input) {
                  if (input.isEmpty) {
                    Provider.of<SearchStateProvider>(context, listen: false)
                        .disposeSerach();
                  } else {
                    Provider.of<SearchStateProvider>(context, listen: false)
                        .getSearchResult(input);
                  }
                },
              ),
              Consumer<SearchStateProvider>(
                  builder: (context, searchValue, child) {
                if (searchValue.isSearching) {
                  return const CircularProgressIndicator();
                } else if (searchValue.serachHits != null) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                        itemCount: searchValue.serachHits!.length,
                        itemBuilder: ((context, index) =>
                            moviePoster(searchValue.serachHits![index], true)),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        )),
                  );
                }
                return Column();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget moviePoster(Movie movie, bool active) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Consumer<MyState>(
        builder: (context, state, child) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (con) => MovieDetails(movie.id)));
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
                    ? Image.asset("./assets/spiderman.jpg")
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
}
