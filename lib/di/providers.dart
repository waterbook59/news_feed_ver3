import 'package:newsfeedver3/models/db/news_dao.dart';
import 'package:newsfeedver3/models/db/news_database.dart';
import 'package:newsfeedver3/models/networking/news_api_service.dart';
import 'package:newsfeedver3/models/repositories/news_repository.dart';
import 'package:newsfeedver3/view_models/head_line_view_model.dart';
import 'package:newsfeedver3/view_models/news_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [
  Provider<NewsApiService>(
    //ここはNewsApiService()ではなく、staticのNewsApiService.create()
    create: (_) => NewsApiService.create(),
    //閉じる時はcloseではなく、dispose(dbはclose)
    dispose: (_, newsApiService) => newsApiService.dispose(),
  ),
  Provider<MyNewsDB>(
    create: (_)=>MyNewsDB(),
    dispose: (_,db) =>db.close(),
  ),
];

List<SingleChildWidget> dependentModels = [
  //NewsDaoのコンストラクタのdi(引数をdbに)を下記に修正
  ProxyProvider<MyNewsDB,NewsDao>(
    update: (_, db, dao)=>NewsDao(db),
  ),
  ProxyProvider2<NewsDao,NewsApiService, NewsRepository>(
    update: (_, newsDao,newsApiService, repository) =>
        NewsRepository(newsDao:newsDao,newsApiService: newsApiService),
  ),

];

//使うたびに異なるrepositoryのインスタンスを作る必要がある場合はChangeNotifierProxyProvider使う
//todo repositoryの修正をviewModelへ自動通知する時にChangeNotifierProxyProvider使う？
List<SingleChildWidget> viewModels =[
  ChangeNotifierProvider<NewsListViewModel>(
    create: (context)=> NewsListViewModel(
      repository:Provider.of<NewsRepository>(context, listen: false),
    ),
  ),
  ChangeNotifierProvider<HeadLineViewModel>(
    create: (context)=> HeadLineViewModel(
      repository:Provider.of<NewsRepository>(context, listen: false),
    ),
  ),
];