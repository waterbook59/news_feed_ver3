import 'package:flutter/material.dart';
import 'package:newsfeedver3/di/providers.dart';
import 'package:newsfeedver3/style.dart';
import 'package:newsfeedver3/views/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: globalProviders,
      child:MyApp() ,
    ),
      );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'news_feed_ver3',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily:  boldFont,
      ),
      home: HomeScreen(),
    );
  }
}
