import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            _imageRow(),
            _headLine("About"),
            _textContainer(),
            _headLine("Cast"),
            _castRow(),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 60,
          ),
          const Expanded(
            child: Text(
              "Spiderman No Way Home",
              style: TextStyle(fontSize: 26),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.watch_later,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _imageRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _image(),
          Padding(
            padding: const EdgeInsets.only(left: 40, bottom: 50, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.watch_later_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        "148 min",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Icon(
                      Icons.star_border_outlined,
                      color: Colors.white,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        "9.5",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Icon(
                      Icons.category_outlined,
                      color: Colors.white,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        "Action",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _image() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: SizedBox.fromSize(
        size: Size.fromRadius(100),
        child: Image.asset(
          './assets/spiderman.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _headLine(String text) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Text(
        text,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _textContainer() {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
        child: Text(
            "With Spider-Man's identity now revealed, Peter asks Doctor Strange for help. When a spell goes wrong, dangerous foes from other worlds start to appear, forcing Peter to discover what it truly means to be Spider-Man."));
  }

  Widget _castRow() {
    var image = AssetImage('assets/tomholland.jpg');
    var list = [image, image, image, image, image, image, image, image];
    return Container(
      margin: EdgeInsets.only(left: 10),
      height: 160,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: list.map((item) => _item(item)).toList(),
      ),
    );
  }

  Widget _item(item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: item,
          ),
          Text("Tom"),
          Text("Holland")
        ],
      ),
    );
  }
}
