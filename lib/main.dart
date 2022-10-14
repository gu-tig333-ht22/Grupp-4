import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_point_tab_bar/pointTabIndicator.dart';
import 'package:template/FavoriteView.dart';
import 'package:template/RatingView.dart';
import 'package:template/WatchListOverview.dart';
import 'package:template/models/movie.dart';
import 'package:template/providers/home_screen_provider.dart';
import 'package:template/providers/search_provider.dart';
import 'package:template/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  var state = MyState();
  state.getMovie();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => state,
      ),
      ChangeNotifierProvider<SearchStateProvider>(create: (context) => SearchStateProvider()),
      ChangeNotifierProvider<HomeScreenStateProvider>(create: (context) => HomeScreenStateProvider())
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color(0xFF27272D),
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
              children: const [
                HomeScreen(),
                FavoriteView(),
                WatchListOverview(),
                RatingView()
              ])),
    );
  }
}
