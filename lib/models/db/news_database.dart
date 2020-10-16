//DBでは独自のモデルクラスを設定し、
//view層で使っているモデルクラス(今回はArticle)へ変換する

import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:newsfeedver3/models/db/news_dao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'news_database.g.dart';

class ArticleRecords extends Table{

//step3のテーブルクラスの定義時に記載
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get url => text()();
  TextColumn get urlToImage => text()();
  TextColumn get publishedAt => text()();
  TextColumn get content => text()();

  //プライマリーキーに紐付けてDBを操作しないので、設定なし
}
  //@UseMoorはTableの外
//コード生成の後、
// 1.$クラスextends, 2.スキーマバージョン設定、3.コンストラクタ設定、4.openConnectionのファンクション！作成
  @UseMoor(tables:[ArticleRecords],daos: [NewsDao])
  class MyNewsDB extends _$MyNewsDB{
  MyNewsDB() : super(_openConnection());
  
  @override
  int get schemaVersion => 1;
  }


//5.getApplicationDocumentsDirectoryをpath_providerインポート
//6.Fileを'dart.io'をインポート(dart.htmlは✖︎)
//7.VmDatabaseはmoor_ffiインポート
//8. 'package:path/path.dart' as pをインポートして名前付きのトップレベル関数としてjoinに紐付ける
//9. スマホ内のfile名を変更したい場合はデフォルト名'db.sqlite'を変更
LazyDatabase _openConnection() {

  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    //下はpath_providerの一般的な書き方
    final file = File(p.join(dbFolder.path, 'news.db'));
    return VmDatabase(file);
  });
}






