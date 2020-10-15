import 'package:flutter/material.dart';
import 'package:newsfeedver3/views/head_line/components/page_transformer.dart';

class LazyLoadText extends StatelessWidget {
  const LazyLoadText({this.text, this.pageVisibility});

  final String text;
  final PageVisibility pageVisibility;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
//    print('pagePosition:${pageVisibility.pagePosition}');

    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        //どこからtransformを反映させるか？
        alignment: Alignment.topLeft,
        transform:
        //pageVisibility.pagePositionは-1~1
            //開始が2の位置からずれているので、
            Matrix4.translationValues(pageVisibility.pagePosition * 300, 0, 0),
        child: Text(
          text,
          style: textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
