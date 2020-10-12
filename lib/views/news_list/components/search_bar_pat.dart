import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBarPart extends StatelessWidget {
  SearchBarPart({@required this.onSearch,this.errorText});

  final ValueChanged<String> onSearch;
  final TextEditingController _textEditingController = TextEditingController();
  //todo errorText表示
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: TextField(
        maxLines: 1,
        decoration: const InputDecoration(
          icon: FaIcon(FontAwesomeIcons.search),
          hintText: '検索ワードを入れてください',
          border: InputBorder.none,
        ),
        controller: _textEditingController,
        onSubmitted: onSearch,
      ),
    );
  }
}
