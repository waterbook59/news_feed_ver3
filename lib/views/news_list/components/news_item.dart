import 'package:flutter/material.dart';
import 'package:newsfeedver3/data_models/article.dart';

class NewsItem extends StatelessWidget {

  const NewsItem({this.eachArticle});
  final Article eachArticle;

  @override
  Widget build(BuildContext context) {
    return
         Card(//CardはListView.builderの下におく！！
           shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
          child: Column(
            children: [
              Text(eachArticle.urlToImage),
              Text(eachArticle.title),
              Text(eachArticle.description),
            ],
          ),
        );
  }
}
