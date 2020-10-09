import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsfeedver3/data_models/category.dart';
import 'package:newsfeedver3/utils/constants.dart';
import 'package:newsfeedver3/view_models/news_list_view_model.dart';
import 'package:newsfeedver3/views/news_list/components/category_chips_part.dart';
import 'package:newsfeedver3/views/news_list/components/search_bar_pat.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SearchBarPart(
              onSearch: (keyword) => getKeywordNews(context, keyword),
            ),
            CategoryChipsPart(
              onSelectedCategory: (selectedCategory) =>
                  getCategoryNews(context, selectedCategory),
            ),
//          NewsItem(),
            const Expanded(child: Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const FaIcon(FontAwesomeIcons.redo),
        onPressed: () => onRefreshed(context),
      ),
    );
  }

  //todo 記事更新 同じ検索処理を行う用にviewModel層にgetNewsの引数をプロパティとして設定
  Future<void> onRefreshed(BuildContext context) async {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(
      searchType: viewModel.searchType,
      keyword: viewModel.keyword,
      category: viewModel.category,
    );
  }

  //todo キーワード検索(keywordはSearchBarに入力した文字)
  Future<void> getKeywordNews(BuildContext context, String keyword) async {
    print('keyword:$keyword');
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);

    await viewModel.getNews(
        searchType: SearchType.keywordSearch, keyword: keyword);
  }

  //todo カテゴリ検索
  Future<void> getCategoryNews(BuildContext context,
      Category selectedCategory) async {
    print('selectedCategory:${selectedCategory.nameJp}');
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(
        searchType: SearchType.categorySearch, category: selectedCategory);
  }
}
