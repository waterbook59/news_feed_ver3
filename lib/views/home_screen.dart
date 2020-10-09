import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsfeedver3/views/about_us/pages/about_us_page.dart';
import 'package:newsfeedver3/views/head_line/pages/head_line_page.dart';
import 'package:newsfeedver3/views/news_list/pages/news_list_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  //各pageをリストに pages=[]
  final List<Widget> _pages = <Widget>[
    HeadLinePage(),
    NewsListPage(),
    AboutUsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.highlight),
                title: Text('トップニュース')),
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                title: Text('ニュース一覧')),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.angellist),
                title: Text('このアプリについて')),
          ],
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        ),
        body: _pages[_currentIndex],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
