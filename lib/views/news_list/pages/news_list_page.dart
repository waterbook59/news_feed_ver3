import 'package:flutter/material.dart';
import 'package:newsfeedver3/views/news_list/components/category_chips_part.dart';
import 'package:newsfeedver3/views/news_list/components/search_bar_pat.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBarPart(),
          CategoryChipsPart(),
//          NewsItem(),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
