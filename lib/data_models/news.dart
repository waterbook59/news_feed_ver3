import 'package:flutter/material.dart';
import 'package:newsfeedver3/data_models/article.dart';

class News {
  final String status;
  final int totalResults;
  final List<Article> articles;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const News({
    @required this.status,
    @required this.totalResults,
    @required this.articles,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is News &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          totalResults == other.totalResults &&
          articles == other.articles);

  @override
  int get hashCode =>
      status.hashCode ^ totalResults.hashCode ^ articles.hashCode;

  @override
  String toString() {
    return 'News{' +
        ' status: $status,' +
        ' totalResults: $totalResults,' +
        ' articles: $articles,' +
        '}';
  }

  News copyWith({
    String status,
    int totalResults,
    List<Article> articles,
  }) {
    return  News(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      articles: articles ?? this.articles,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': this.status,
      'totalResults': this.totalResults,
      'articles': this.articles,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return  News(
      status: map['status'] as String,
      totalResults: map['totalResults'] as int,
      //articles: map['articles'] as List<Article>,
      // 上のそのままの変換はできなくて、
      //たぶん対象のJsonレスポンスは List<Map<String, dynamic>>になってるので、
      // Map<String, dynamic>にループして変換させる必要がある
      articles: (map['articles'] as List)
          ?.map((e) =>
              e == null ? null : Article.fromMap(e as Map<String, dynamic>))
          ?.toList(),
    );
  }

//</editor-fold>
}
