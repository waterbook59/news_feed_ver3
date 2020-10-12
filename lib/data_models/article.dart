
import 'package:flutter/material.dart';

class Article {
final String title;
final String description;
final String url;
final String urlToImage;
//@JsonKey(name: 'publishedAt')
final String publishedAt;
final String content;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Article({
    @required this.title,
    @required this.description,
    @required this.url,
    @required this.urlToImage,
    @required this.publishedAt,
    @required this.content,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Article &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          description == other.description &&
          url == other.url &&
          urlToImage == other.urlToImage &&
          publishedAt == other.publishedAt &&
          content == other.content);

  @override
  int get hashCode =>
      title.hashCode ^
      description.hashCode ^
      url.hashCode ^
      urlToImage.hashCode ^
      publishedAt.hashCode ^
      content.hashCode;

  @override
  String toString() {
    return 'Article{' +
        ' title: $title,' +
        ' description: $description,' +
        ' url: $url,' +
        ' urlToImage: $urlToImage,' +
        ' publishedAt: $publishedAt,' +
        ' content: $content,' +
        '}';
  }

  Article copyWith({
    String title,
    String description,
    String url,
    String urlToImage,
    String publishedAt,
    String content,
  }) {
    return  Article(
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'description': this.description,
      'url': this.url,
      'urlToImage': this.urlToImage,
      'publishedAt': this.publishedAt,
      'content': this.content,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return  Article(
      title: map['title'] as String,
      description: map['description'] as String,
      url: map['url'] as String,
      urlToImage: map['urlToImage'] as String,
      publishedAt: map['publishedAt'] as String,
      content: map['content'] as String,
    );
  }

//</editor-fold>
}