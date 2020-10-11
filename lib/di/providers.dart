import 'package:newsfeedver3/models/networking/news_api_service.dart';
import 'package:newsfeedver3/models/repositories/news_repository.dart';
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
];

List<SingleChildWidget> dependentModels = [
//  ProxyProvider<MyDatabase,TasksDao>(
//    update: (_, db, dao)=>TasksDao(db),
//  ),
  ProxyProvider<NewsApiService, NewsRepository>(
    update: (_, newsApiService, repository) =>
        NewsRepository(newsApiService: newsApiService),
  ),
];

List<SingleChildWidget> viewModels =[
  ChangeNotifierProvider<NewsListViewModel>(
    create: (context)=> NewsListViewModel(
      repository:Provider.of<NewsRepository>(context, listen: false),
    ),
  ),
];