import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:template/models/movie.dart';
import 'package:template/models/review.dart';
import 'package:template/providers/review_provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

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
          backgroundColor: const Color(0xFF27272D),
          title: Text(widget.movie.title),
        ),
        body: Consumer<ReviewProvider>(
          builder: (context, value, child) {
            if (value.reviews == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (value.reviews!.isEmpty) {
              // ignore: sized_box_for_whitespace
              return const Center(child: Text("No reviews found."));
            }
            return ListView(
              children: [
                ...value.reviews!.map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 200,
                            width: 600,
                            child: Markdown(data: e.content),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xFF27272D),
                            ),
                            /*child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.content),
                            ),*/
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(e.author,
                                style:
                                    const TextStyle(color: Color(0xFF0296E5))),
                          ),
                          const SizedBox(height: 10)
                        ],
                      ),
                    ))
              ],
            );
          },
        ));
  }

  @override
  void deactivate() {
    Provider.of<ReviewProvider>(context, listen: false).clearReviews();
    super.deactivate();
  }
}
