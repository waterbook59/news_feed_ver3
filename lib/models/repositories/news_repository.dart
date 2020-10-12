import 'package:chopper/chopper.dart';
import 'package:newsfeedver3/data_models/article.dart';
import 'package:newsfeedver3/data_models/category.dart';
import 'package:newsfeedver3/data_models/news.dart';
import 'package:newsfeedver3/models/networking/news_api_service.dart';
import 'package:newsfeedver3/utils/constants.dart';

class NewsRepository {
  //news_api_service内のstaticなNewsApiService.createメソッドを使うことで、
  // サーバーへHTTPリクエストするbaseUrlやapiKeyの下準備設定まで完了

  //DiのときはApiService.createはいらなくて、providersの中で実行
  NewsRepository({newsApiService}) : _newsApiService = newsApiService;
  final NewsApiService _newsApiService;

  //DIなし
//  final NewsApiService _apiService = NewsApiService.create();

  //chopperへ投げる
  Future<List<Article>> getNews({
      SearchType searchType, String keyword, Category category}) async {
    //NewsApiService.createメソッドをベースに
    // ＠Getのメソッドに対して、クエリで入力してないもの(キーワードやカテゴリ)を渡す

    Response response;
    var result = <Article>[];

    //try-catchで成功、レスポンス返ってきたけど失敗、レスポンス返ってこないの3パターン
    try {
      switch (searchType) {
        case SearchType.headline:
          response = await _newsApiService.getHeadLineNews();
          break;
        case SearchType.keywordSearch:
          response = await _newsApiService.getKeywordNews(q: keyword);
          //レスポンスがぜ〜ろ〜:リクエストが上手いこといってない=>countryがjpじゃなくてjaになってる！！！！
          print('キーワード検索のresponse.body[articles]:${response.body['articles']}');
          break;
        case SearchType.categorySearch:
          //カテゴリーをクエリへ投げる時は英文字で
          response =
              await _newsApiService.getCategoryNews(category: category.nameEn);
          print('カテゴリ検索のカテゴリ:${category.nameEn}と'
              'response.body[articles]:${response.body['articles']}');
          break;
      }
      //NewsApiServiceのメソッドを使って返ってくるのは戻り値Responseクラス(json形式)なので、
      // fromJsonメソッド使ってresponse.bodyのarticlesだけをList<Article>として格納する
      if (response.isSuccessful) {
        //response.bodyがdynamicなので、Map型へ変換する必要あり?
        //=>analysis_options.yamlの暗黙的型変換の条件緩めるとエラーなし
        final responseBody = response.body;
        print('responseBody:$responseBody');

        //json_serializableではなく、DartDataClass使用
        result = News.fromMap(responseBody).articles;
        print('News.fromMap変換後のList<Article>:$result');
      } else {
        //レスポンス返ってきたけど失敗(responseの中のstatusCode,errorを出す)
        final errorCode = response.statusCode;
        final error = response.error;
        print('response is not successful:$errorCode / $error');
      }
    } on Exception catch (error) {
      print('error:$error');
    }
    //returnはArticleリスト形式に
    return result;
  }

//try-catchが終わったらNewsApiServiceのdisposeメソッド実行
//viewModelでもrepository.disposeを行う,globalProviderにあるからいらない？？
  void dispose() {
    _newsApiService.dispose();
  }
}
