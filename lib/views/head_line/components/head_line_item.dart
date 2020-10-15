import 'package:flutter/material.dart';
import 'package:newsfeedver3/data_models/article.dart';
import 'package:newsfeedver3/views/common_components/article_image.dart';
import 'package:newsfeedver3/views/head_line/components/lazy_load_text.dart';
import 'package:newsfeedver3/views/head_line/components/page_transformer.dart';

class HeadLineItem extends StatelessWidget {
  const HeadLineItem(
      {this.eachArticle, this.pageVisibility, this.onArticleTapped});

  final Article eachArticle;
  final PageVisibility pageVisibility;
  final ValueChanged<Article> onArticleTapped;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () => onArticleTapped(eachArticle),
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              position: DecorationPosition.foreground,
              decoration:const  BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  //begin・endの順番
                  colors: [Colors.black87,Colors.black12],
                )
              ),
              child: ArticleImage(
                imageUrl: eachArticle.urlToImage,
              ),
            ),
            Positioned(
              bottom: 56,
              left: 32,
              right: 32,
              child: LazyLoadText(text: eachArticle.title,
              pageVisibility: pageVisibility,)
            ),
          ],
        ),
      ),
    );
  }
}
