import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 29, 29, 33),
        title: Center(
          child: Text(
            "Spiderman No Way Home",
            style: TextStyle(fontSize: 24),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.bookmark_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

  Widget _imageRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _image(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 40, bottom: 50, top: 20),
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
            ),
          )
        ],
      ),
    );
  }

  Widget _image() {
    return Expanded(
      child: Container(
        height: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            image: DecorationImage(
                image: AssetImage("./assets/spiderman.jpg"),
                fit: BoxFit.cover)),
      ),
    );
  }

/*

  Widget _image() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: SizedBox.fromSize(
        size: Size.fromRadius(150),
        child: Image.asset(
          './assets/spiderman.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
*/

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
      height: 200,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: list.map((item) => _item(item)).toList(),
      ),
    );
  }

  Widget _item(item) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, right: 15, bottom: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: item,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "Tom\nHolland",
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
