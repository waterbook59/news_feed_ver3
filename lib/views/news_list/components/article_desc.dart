import 'package:flutter/material.dart';
import 'package:newsfeedver3/data_models/article.dart';
import 'package:newsfeedver3/style.dart';

class ArticleDesc extends StatelessWidget {
  const ArticleDesc({this.eachArticle});

  final Article eachArticle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    //descriptionがnullの場合、除外しないと落ちるのでnullじゃない場合のみ描画
    var description='';
    if(eachArticle.description !=null){
      description =eachArticle.description;
    }



    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          eachArticle.title,
          style: textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(eachArticle.publishedAt,
            style: textTheme.overline.copyWith(fontFamily:regularFont,
                fontStyle: FontStyle.italic),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          description,
          style: textTheme.bodyText1.copyWith(fontFamily: regularFont),
        ),
      ],
    );
  }
}
