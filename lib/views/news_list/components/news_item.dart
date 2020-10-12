import 'package:flutter/material.dart';
import 'package:newsfeedver3/data_models/article.dart';
import 'package:newsfeedver3/style.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({this.eachArticle, this.onArticleTapped});

  final Article eachArticle;
  final ValueChanged<Article> onArticleTapped;

  @override
  Widget build(BuildContext context) {
    return Card(
      //CardはListView.builderの下におく！！
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        //todo タップでwebページへ
        //valueChangeで引数入れる時は()=>fanc()はじめのかっこは必須！
        onTap: () => onArticleTapped(eachArticle),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  //画像
                  child: Text(eachArticle.urlToImage),
                )),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      eachArticle.title,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(eachArticle.publishedAt,
                        style: const TextStyle(
                            fontFamily: regularFont, fontSize: 13)),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      eachArticle.description,
                      style: const TextStyle(fontFamily: regularFont),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
