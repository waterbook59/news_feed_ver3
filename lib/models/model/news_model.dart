import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class News {
  final String status;
  final int totalResults;
  final List<Article> articles;

  // ignore: sort_constructors_first
  News({this.status, this.totalResults, this.articles});

  // ignore: sort_constructors_first
  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

@JsonSerializable()
class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  @JsonKey(name: 'publishedAt')
  final String publishDate;
  final String content;

  // ignore: sort_constructors_first
  Article(
      {this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishDate,
      this.content});

  // ignore: sort_constructors_first
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
