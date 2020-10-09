import 'package:newsfeedver3/data_models/article.dart';
import 'package:newsfeedver3/data_models/category.dart';
import 'package:newsfeedver3/utils/constants.dart';

class NewsRepository {
  Future<List<Article>> getNews(
      SearchType searchType, String keyword, Category category) async {
    //chopperへ投げる
  }
}
