import 'package:chopper/chopper.dart';
import 'package:newsfeedver3/data_models/article.dart';
import 'package:newsfeedver3/data_models/category.dart';
import 'package:newsfeedver3/data_models/news.dart';
import 'package:newsfeedver3/models/model/news_model.dart';
import 'package:newsfeedver3/models/networking/news_api_service.dart';
import 'package:newsfeedver3/utils/constants.dart';

class NewsRepository {
//  NewsRepository({NewsApiService newsApiService})
//      :_newsApiService = newsApiService;
//  final NewsApiService _newsApiService;

  //news_api_service内のstaticなNewsApiService.createメソッドを使うことで、
  // サーバーへHTTPリクエストするbaseUrlやapiKeyの下準備設定まで完了
  //todo staticなのでDI必要なし？？

  final NewsApiService _apiService = NewsApiService.create();


  //chopperへ投げる
  Future<List<Article>> getNews(SearchType searchType, String keyword,
      Category category) async {
    //NewsApiService.createメソッドをベースに
    // ＠Getのメソッドに対して、クエリで入力してないもの(キーワードやカテゴリ)を渡す

    Response response;
    List<Article> result = <Article>[];

    //try-catchで成功、レスポンス返ってきたけど失敗、レスポンス返ってこないの3パターン
    try {
      switch (searchType) {
        case SearchType.headline:
          response = await _apiService.getHeadLineNews();
          break;
        case SearchType.keywordSearch:
          response = await _apiService.getKeywordNews(q: keyword);
          break;
        case SearchType.categorySearch:
        //カテゴリーをクエリへ投げる時は英文字で
          response =
          await _apiService.getCategoryNews(category: category.nameEn);
          break;
      }
      //NewsApiServiceのメソッドを使って返ってくるのは戻り値Responseクラス(json形式)なので、
      // fromJsonメソッド使ってresponse.bodyのarticlesだけをList<Article>として格納する
      if(response.isSuccessful){
        //response.bodyがdynamicなので、Map型へ変換する必要あり?
        //=>analysis_options.yamlの条件緩めるとエラーなし
        final responseBody = response.body;
        //json_serializableではなく、DartDataClass使用
        result = News.fromMap(responseBody).articles;
      }else{

      }
    }on Exception catch(error){
      print('error:$error');
    }
    //returnはArticleリスト形式に
    return result;


    //try-catchが終わったらNewsApiServiceのdisposeメソッド実行
    //viewModelでもrepository.disposeを行う
  }
}
