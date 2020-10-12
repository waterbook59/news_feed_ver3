import 'package:flutter/material.dart';
import 'package:newsfeedver3/data_models/article.dart';
import 'package:newsfeedver3/utils/constants.dart';
import 'package:newsfeedver3/view_models/head_line_view_model.dart';
import 'package:provider/provider.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    if (!viewModel.isProcessing && viewModel.articles.isEmpty){
          Future(() {
            return viewModel.getNews(searchType: SearchType.headline,);
    });
    }


    return Scaffold(
      body:Consumer<HeadLineViewModel>(builder: (context, model, child) {
        print('Consumer通ったよ');
        return
//FutureBuilder使うとページ切替時に再読み込みされる
//          FutureBuilder(
//          future: model.getHeadLineNews(searchType: SearchType.headline),
//          builder: (context, AsyncSnapshot<List<Article>> snapshot) {
//            //ページ開く時だけデータ取得
//            //snapshot.data.isEmptyじゃなくて(データは空で返ってこないので)、model.articles.isEmpty
//            if(snapshot.hasData && model.articles.isEmpty){
//              print('Listが空っぽの時だけリスト取得');
//              return Container();
//            }
//            else {
//              return model.isProcessing
//                  ? const Center(child: CircularProgressIndicator())
//                  : ListView.builder(
//                  itemCount: model.articles.length,
//                  itemBuilder: (context, int index) {
//                    return Column(
//                      children: [
//                        Center(child: Text(model.articles[index].title)),
//                        Center(child: Text(model.articles[index].description)),
//                        Center(child: Text(model.articles[index].urlToImage)),
//                      ],
//                    );
//                  });
//            }
//          },
//        );
          
          model.isProcessing
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
              itemCount: model.articles.length,
              itemBuilder: (context, int index) {
              return Column(
                children: [
                  Center(child: Text(model.articles[index].title)),
                  Center(child: Text(model.articles[index].description)),
                  Center(child: Text(model.articles[index].urlToImage)),
                ],
              );
            });
      }),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.refresh),
            onPressed: ()=>_onRefreshed(context),
    ),
  );
  }

  Future<void> _onRefreshed(BuildContext context) async{
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    await viewModel.getNews(searchType: SearchType.headline);
  }
}