import 'package:flutter/material.dart';
import 'package:newsfeedver3/data_models/article.dart';
import 'package:newsfeedver3/style.dart';
import 'package:newsfeedver3/views/news_list/components/article_desc.dart';
import 'package:newsfeedver3/views/common_components/article_image.dart';

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
        //NewsListPageから渡されてきたeachArticleを引数に入れてそのままNewsListPageへ返すイメージ
        onTap: () => onArticleTapped(eachArticle),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ArticleImage(imageUrl: eachArticle.urlToImage,),
                )),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child:ArticleDesc(eachArticle: eachArticle,)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
