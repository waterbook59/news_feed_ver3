import 'package:flutter/material.dart';
import 'package:newsfeedver3/data_models/article.dart';
import 'package:newsfeedver3/data_models/category.dart';
import 'package:newsfeedver3/models/repositories/news_repository.dart';
import 'package:newsfeedver3/utils/constants.dart';

class NewsListViewModel extends ChangeNotifier {

  NewsListViewModel({NewsRepository repository}) : _newsRepository = repository;
  final NewsRepository _newsRepository;

  SearchType _searchType = SearchType.headline;
  SearchType get searchType => _searchType;
  String _keyword = '';
  String get keyword => _keyword;
  Category _category = categories[0];
  Category get category => _category;

  bool isProcessing = false;
  List<Article> _articles = <Article>[];

  Future<void> getNews(
      {@required SearchType searchType,
      String keyword,
      Category category}) async {

    isProcessing= true;
    notifyListeners();
    //記事更新用に入ってきた条件をセット
    _searchType=searchType;
    _keyword = keyword;
    _category = category;

   _articles= await _newsRepository.getNews(searchType,keyword,category);

    //todo リストが空の場合の条件分岐
    isProcessing =false;
    notifyListeners();
  }
}
