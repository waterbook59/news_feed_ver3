import 'package:flutter/material.dart';
import 'package:newsfeedver3/data_models/category.dart';

class CategoryChipsPart extends StatefulWidget {

  const CategoryChipsPart({this.onSelectedCategory});
  final ValueChanged<Category> onSelectedCategory;

  @override
  _CategoryChipsPartState createState() => _CategoryChipsPartState();
}

class _CategoryChipsPartState extends State<CategoryChipsPart> {
  int _value = 0;


  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      children: List<Widget>.generate(
        7,
            (int index) {
          return ChoiceChip(
            selectedColor: Colors.white70,
            label: Text('${categories[index].nameJp}'),
            selected: _value == index,  //_valueは今表示している番号、indexは選択した番号
            onSelected: (bool selected) {
//              print('ChoiceChipのselected:$selected');
              //null状態のチップを押すとselectedがtrueに
              setState(() {
//                print('ChoiceChipのvalue:$_value');
//                print('ChoiceChipのindex:$index');
                _value = selected ? index : null;   // _value=nullだと選択されていない状態
//                print('ChoiceChipの変更後のvalue:$_value');
                widget.onSelectedCategory(categories[index]);
              });
            },
          );
        },
      ).toList(),
    );
  }
}

