import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsfeedver3/data_models/article.dart';
import 'package:newsfeedver3/data_models/category.dart';
import 'package:newsfeedver3/utils/constants.dart';
import 'package:newsfeedver3/view_models/news_list_view_model.dart';
import 'package:newsfeedver3/views/news_list/components/category_chips_part.dart';
import 'package:newsfeedver3/views/news_list/components/news_item.dart';
import 'package:newsfeedver3/views/news_list/components/search_bar_pat.dart';
import 'package:newsfeedver3/views/web_view/screen/web_view_screen.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);

    Future(() async{
      await viewModel.setValidateClear();//再度ページ開いた時にはエラーテキスト消す
      //ページを開いた時にカテゴリー総合でデータ取得 処理中でない且つisEmptyの時だけ取得
      //この条件を入れることで、ページ遷移する時にチラッと映らない
        if (!viewModel.isProcessing && viewModel.articles.isEmpty){
        return viewModel.getNews(
          searchType: SearchType.categorySearch,
          category: categories[0],
        );
        }
      });



    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Consumer<NewsListViewModel>(
              builder: (context, model, child) {
                print('SearchBarPartのConsumer');
                return
                  //初回(テキスト完了ボタン押す時)はisValidationがtrueのままでエラー表示
                  // 再描画時にはmodel.isValidationをfalseにしてstrをnullにしたい
                  //FutureBuilderでSearchBarPartの描画わけすればできるかも？
                  SearchBarPart(
                  //onSearch実行時にvalidation実施
                  onSearch: (keyword) => getKeywordNews(context, keyword),
                  //テキストを結局model層へセット
                  textEditingController: model.keywordController,
                  errorText: model.isValidation ? model.strValidateName : null,
                  didChanged: (updateKeyword) =>
                      updateValidateKeyword(context, updateKeyword),
                );
              },
            ),
            CategoryChipsPart(
              onSelectedCategory: (selectedCategory) =>
                  getCategoryNews(context, selectedCategory),
            ),
            Expanded(
              child:
                  Consumer<NewsListViewModel>(builder: (context, model, child) {
//                print('Consumer通ったよ');
                return model.isProcessing
                    ? const Center(child: CircularProgressIndicator())
                    //ListView.builderはwidget分割して外に出すとエラーになってしまうので、ここに記載すること！！
                    //ページ開いた時にConsumer１度まわるのでここでFuture.Builderしたら冒頭のgetNewsいらない？？
                    //開いた時：カテゴリ総合でgetNews、それ以外:NewsItem
                    //=>引数SearchTypeの場合わけがめんどくさそうなので、冒頭で開いた時に限定してgetNews
                    : ListView.builder(
                        itemCount: model.articles.length,
                        itemBuilder: (context, int index) {
                          return NewsItem(
                            eachArticle: model.articles[index],
                            //タップでwebページへ
                            // (article)はwidget分割先から返ってきたeachArticle(元々こっちから渡した値やけど)
                            onArticleTapped: (article) =>
                                _openWebPage(context, article),
                          );
                        });
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const FaIcon(FontAwesomeIcons.redo),
        onPressed: () => onRefreshed(context),
      ),
    );
  }

  //記事更新 同じ検索処理を行う用にviewModel層にgetNewsの引数をプロパティとして設定
  Future<void> onRefreshed(BuildContext context) async {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(
      searchType: viewModel.searchType,
      keyword: viewModel.keyword,
      category: viewModel.category,
    );
  }

  //キーワード検索(keywordはSearchBarに入力した文字)
  Future<void> getKeywordNews(BuildContext context, String keyword) async {
//    print('keyword:$keyword');
  //ここだけページを写す時に再描画?
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);

    //バリデーションしてからgetNews
//    viewModel.setValidate();
    await viewModel.validateKeyword();//入力が空かどうか
    if(viewModel.keywordController.text.isNotEmpty){//入力が空だったらデータ取得しない
      await viewModel.getNews(
          searchType: SearchType.keywordSearch, keyword: keyword);
    }




  }

  Future<void> updateValidateKeyword(
      BuildContext context, String updateKeyword) async {
    final viewModel = Provider.of<NewsListViewModel>(context,listen: false);
    await viewModel.updateValidateKeyword();
    await viewModel.getNews(
        searchType: SearchType.keywordSearch, keyword: updateKeyword);
  }

  //カテゴリ検索
  Future<void> getCategoryNews(
      BuildContext context, Category selectedCategory) async {
    print('selectedCategory:${selectedCategory.nameJp}');
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(
        searchType: SearchType.categorySearch, category: selectedCategory);
  }

  //タップでwebページへ
  void _openWebPage(BuildContext context, Article article) {
//    print('ページ開くよ：${article.url}');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(
          article: article,
        ),
      ),
    );
  }
}
