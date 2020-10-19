import 'package:flutter/material.dart';
import 'package:newsfeedver3/data_models/article.dart';
import 'package:newsfeedver3/models/repositories/news_repository.dart';
import 'package:newsfeedver3/utils/constants.dart';

class HeadLineViewModel extends ChangeNotifier{

  HeadLineViewModel({NewsRepository repository}):
        _newsRepository = repository;
  final NewsRepository _newsRepository;


  bool _isProcessing = false;
  bool get isProcessing => _isProcessing;
  List<Article> _articles = <Article>[];
  List<Article> get articles => _articles;

  Future<void> getNews(
      {@required SearchType searchType,}) async {

    //記事更新用に入ってきた条件をセット いる？？
//    _searchType=searchType;

    _isProcessing= true;
    notifyListeners();

    _articles= await _newsRepository.getNews(searchType: searchType);
//    print('getNews:${_articles[0].title}');

    //リストが空の場合の条件分岐は...repositoryのtry/catchでやってる
    _isProcessing =false;
    notifyListeners();
  }

  Future<List<Article>> getHeadLineNews({SearchType searchType}) async{
    _isProcessing= true;
    _articles = await _newsRepository.getNews(searchType: searchType);
    _isProcessing= false;
    return _articles;

  }

  @override
  void dispose() {
    _newsRepository.dispose();
    super.dispose();
  }

}