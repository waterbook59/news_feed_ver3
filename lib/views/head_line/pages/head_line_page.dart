import 'package:flutter/material.dart';
import 'package:newsfeedver3/data_models/article.dart';
import 'package:newsfeedver3/utils/constants.dart';
import 'package:newsfeedver3/view_models/head_line_view_model.dart';
import 'package:newsfeedver3/views/head_line/components/page_transformer.dart';
import 'package:provider/provider.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    if (!viewModel.isProcessing && viewModel.articles.isEmpty) {
      Future(() {
        return viewModel.getNews(
          searchType: SearchType.headline,
        );
      });
    }

    return SafeArea(
      child: Scaffold(
        body: Consumer<HeadLineViewModel>(builder: (context, model, child) {
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
                  : PageTransformer(
                      pageViewBuilder: (context, pageVisibilityResolver) {
                        return PageView.builder(
                            //表示するページをそれぞれ変えたい場合は普通のPageView
                            controller: PageController(),
                            itemCount: model.articles.length,
                            itemBuilder: (context, int index) {
                              final article = model.articles[index];
                              //pageVisibilityResolverは見た目の情報を格納するクラス
                              //resolvePageVisibilityはページのどこにあるかを計算
                              final pageVisibility = pageVisibilityResolver
                                  .resolvePageVisibility(index);
        //透明度の値に入力、pageVisibility.pagePositionは-1~1,visibleFractionは0~1
                              final visibleFraction =
                                  pageVisibility.visibleFraction;
                              return Opacity(
                                opacity: visibleFraction,
                                child: Center(
                                  child: Container(
                                    color: Colors.blueGrey,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Center(child: Text(article.title)),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                            child: Text(article.description)),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Center(child: Text(article.urlToImage)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    );
        }),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () => _onRefreshed(context),
        ),
      ),
    );
  }

  Future<void> _onRefreshed(BuildContext context) async {
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    await viewModel.getNews(searchType: SearchType.headline);
  }
}
