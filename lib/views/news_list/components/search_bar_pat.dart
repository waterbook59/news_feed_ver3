import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBarPart extends StatelessWidget {
  SearchBarPart(
      {@required this.onSearch,
      this.textEditingController,
      this.errorText,
      this.didChanged});

  final ValueChanged<String> onSearch;

  //モデル層でtextEditingController持つ場合はコンストラクタのTextEditingController()は
  //モデル層でセット。分割先では下記に留めておく。
  //1.モデル層で入力値を持つ場合（SearchBarPartもconstになる）
  final TextEditingController textEditingController;

  //2.分割先で入力値を持つ場合
//  final TextEditingController textEditingController = TextEditingController();

  //errorText表示
  final String errorText;
  final ValueChanged<String> didChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: TextField(
        maxLines: 1,
        decoration: InputDecoration(
          icon: const FaIcon(FontAwesomeIcons.search),
          hintText: '検索ワードを入れてください',
          border: InputBorder.none,
          errorText: errorText,
        ),
        controller: textEditingController,
        onChanged: didChanged,
        onSubmitted: onSearch,
      ),
    );
  }
}
