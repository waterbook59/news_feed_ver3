

import 'package:newsfeedver3/data_models/article.dart';
import 'package:newsfeedver3/models/db/news_database.dart';

//api=>DB(ArticleからArticleRecord)
extension ConvertToArticleRecord on List<Article>{
  //articleリストを入れるとarticleRecordのリスト(戻り値設定)で返ってくる
  List<ArticleRecord> toArticleRecord(List<Article> articles){
    final articleRecords = <ArticleRecord>[];

     articles.forEach((article) {
       articleRecords.add(
         ArticleRecord(
           title: article.title ?? '',
           description: article.description ?? '',
           url: article.url ?? '',
           urlToImage: article.urlToImage ?? '',
           publishedAt: article.publishedAt ?? '',
           content: article.content ?? '',
         )
       );
     });
    return articleRecords;
  }
}

//DB=>view(ArticleRecordからArticle)
extension ConvertToArticle on List<ArticleRecord>{

  //DBから得られたarticleRecordのリストを入れるとarticle(戻り値設定)で返ってくる
  List<Article> toArticle(List<ArticleRecord> articleRecords){
    final articles =<Article>[];

    articleRecords.forEach((articleRecord) {
      articles.add(
        Article(
          title: articleRecord.title ?? '',
          description: articleRecord.description ?? '',
          url: articleRecord.url ?? '',
          urlToImage: articleRecord.urlToImage ?? '',
          publishedAt: articleRecord.publishedAt ?? '',
          content: articleRecord.content ?? '',
        )
      );
    });
    return articles;
  }

}

