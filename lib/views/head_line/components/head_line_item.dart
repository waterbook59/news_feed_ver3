import 'package:flutter/material.dart';
import 'package:newsfeedver3/data_models/article.dart';
import 'package:newsfeedver3/views/common_components/article_image.dart';
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
            ArticleImage(
              imageUrl: eachArticle.urlToImage,
            ),
            Positioned(
              bottom: 56,
              left: 32,
              right: 32,
              child: Text(
                eachArticle.title,
                style:
                    textTheme.headline5.copyWith(fontWeight: FontWeight.bold),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
