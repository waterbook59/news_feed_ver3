import 'package:moor/moor.dart';
import 'package:newsfeedver3/models/db/news_database.dart';

part 'news_dao.g.dart';

//package:moor/moor.dartをインポートしないとコード生成できない
//コード生成後
// 1.コンストラクタ設定、2.＠UseMoorでdao設定して再コード生成
//クエリ作成
@UseDao(tables: [ArticleRecords])
class NewsDao extends DatabaseAccessor<MyNewsDB> with _$NewsDaoMixin {
  NewsDao(MyNewsDB attachedDatabase) : super(attachedDatabase);

  //DB空にしてからapiServiceのデータを書き込む
  //１つ１つのクエリを普通に書いて、2つ以上のクエリを1つとして実行=>transaction

  //消す
  Future<void> clearDB() {
    return delete(articleRecords).go();
  }

  //入れる(2行以上の挿入はbatch)
  //List<ArticleRecord> articlesの引数のところはテーブル名とかぶるのでarticles
  Future<void> insertDB(List<ArticleRecord> articles) async {
    await batch((batch) {
      //rowsのところにリストを入れる
      batch.insertAll(articleRecords, articles);
    });
  }

  //読み込む
  Future<List<ArticleRecord>> get allArticleRecords =>
      select(articleRecords).get();

  //transaction行う時にも引数はinsertDBのもの(List<ArticleRecord> articles)入れる
  Future<List<ArticleRecord>> insertAndReadFromDB(
      List<ArticleRecord> articles) =>
      transaction(() async {
        await clearDB();
        await insertDB(articles);
        //最後だけ読み込みして結果を返すのでreturn
        //ゲッターなのでallArticleRecordsの後ろは()いらない
        return allArticleRecords;
      });


}