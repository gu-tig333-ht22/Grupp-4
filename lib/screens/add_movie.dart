import 'package:flutter/material.dart';
import 'package:template/providers/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:template/widgets/movie_poster.dart';

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
                Provider.of<SearchStateProvider>(context, listen: false)
                    .disposeSerach();
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
          backgroundColor: const Color(0xFF27272D),
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
          color: const Color(0xFF27272D),
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          alignment: AlignmentDirectional.topStart,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  return const Center(child: CircularProgressIndicator());
                } else if (searchValue.serachHits != null) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                        itemCount: searchValue.serachHits!.length,
                        itemBuilder: ((context, index) =>
                            MoviePoster(movie: searchValue.serachHits![index], active: true)),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1/1.4,
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
}
