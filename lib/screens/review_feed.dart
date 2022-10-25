import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:template/models/movie.dart';
import 'package:template/models/review.dart';
import 'package:template/providers/review_provider.dart';

class ReviewFeed extends StatefulWidget {
  final Movie movie;

  const ReviewFeed({required this.movie, super.key});

  @override
  State<ReviewFeed> createState() => _ReviewFeedState();
}

class _ReviewFeedState extends State<ReviewFeed> {
  List<Review>? reviews;

  @override
  void initState() {
    super.initState();
    Provider.of<ReviewProvider>(context, listen: false)
        .getReviews(widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 29, 29, 33),
          title: Text(widget.movie.title),
        ),
        body: Consumer<ReviewProvider>(
          builder: (context, value, child) {
            if (value.reviews == null) return const CircularProgressIndicator();
            return ListView(
              children: [
                ...value.reviews!.map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 76, 76, 82),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.content),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(e.author,
                                style: const TextStyle(color: Color(0xFF0296E5))),
                          ),
                        ],
                      ),
                    ))
              ],
            );
          },
        ));
  }
}
