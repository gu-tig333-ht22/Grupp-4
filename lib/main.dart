import 'package:flutter/material.dart';
import 'package:flutter_point_tab_bar/pointTabIndicator.dart';
import 'package:template/providers/movie_provider.dart';
import 'package:template/screens/favorite_screen.dart';
import 'package:template/screens/rating_screen.dart';
import 'package:template/screens/watchlist_screen.dart';
import 'package:template/providers/home_screen_provider.dart';
import 'package:template/providers/review_provider.dart';
import 'package:template/providers/search_provider.dart';
import 'package:template/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MovieState>(create: (context) => MovieState()),
      ChangeNotifierProvider<SearchStateProvider>(
          create: (context) => SearchStateProvider()),
      ChangeNotifierProvider<HomeScreenStateProvider>(
          create: (context) => HomeScreenStateProvider()),
      ChangeNotifierProvider<ReviewProvider>(
          create: (context) => ReviewProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //FOR DARKMODE IN SYSTEM
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   systemNavigationBarColor: Color(0xFF27272D),
    //   systemNavigationBarIconBrightness: Brightness.dark,
    //   statusBarBrightness: Brightness.dark,
    // ));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            scaffoldBackgroundColor: const Color.fromARGB(255, 29, 29, 33),
            fontFamily: 'Roboto',
            backgroundColor: const Color(0xFF27272D),
//          textTheme: const TextTheme(
//            headline1: TextStyle(fontSize: 96.0, fontWeight: FontWeight.bold),
//            headline2: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w400),
//            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.normal),
//            bodyText2: TextStyle(fontSize: 14.0,),
//          ),
//          appBarTheme: const AppBarTheme(
//            centerTitle: true,
//            elevation: 0,
//          ),
//          iconTheme: const IconThemeData(
//            color: Colors.white,
//            size: 17,
            //        ),
            //      ),
            textTheme: Theme.of(context)
                .textTheme
                .apply(bodyColor: Colors.white, displayColor: Colors.white)),
        home: const SessionScaffold());
  }
}

class SessionScaffold extends StatefulWidget {
  const SessionScaffold({super.key});

  @override
  State<SessionScaffold> createState() => _SessionScaffoldState();
}

class _SessionScaffoldState extends State<SessionScaffold>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController serachController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this)
      ..addListener(() {
        serachController.text = "";
        Future.delayed(const Duration(milliseconds: 500), 
        () =>  Provider.of<SearchStateProvider>(context, listen: false)
            .disposeSerach());
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 29, 29, 33),
                blurRadius: 10,
                spreadRadius: 15,
              )
            ]),
            height: 55,
            child: TabBar(
              indicator: const PointTabIndicator(
                  position: PointTabIndicatorPosition.bottom,
                  color: Color(0xFF0296E5),
                  insets: EdgeInsets.only(bottom: 10)),
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.home, color: Colors.black)),
                Tab(icon: Icon(Icons.favorite, color: Colors.black)),
                Tab(icon: Icon(Icons.bookmark, color: Colors.black)),
                Tab(icon: Icon(Icons.star, color: Colors.black)),
              ],
            ),
          ),
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                HomeScreen(serachController: serachController),
                const FavoriteScreen(),
                const WatchListScreen(),
                const RatingScreen()
              ])),
    );
  }
}
