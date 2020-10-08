import 'package:flutter/material.dart';
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
  final List<Widget> _pages=[AboutUsPage(),HeadLinePage(),NewsListPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        items:<BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.highlight),title: ),
          BottomNavigationBarItem(icon: Icon(Icons.list),title:),
          BottomNavigationBarItem(icon: ,title:),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
      body: _pages[_currentIndex],

    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
