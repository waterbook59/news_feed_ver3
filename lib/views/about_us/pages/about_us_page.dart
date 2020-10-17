import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsfeedver3/style.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const FaIcon(FontAwesomeIcons.asymmetrik),
          tooltip: '飛び出す！',
          onPressed: () {
            setState(() {
              _isSelected = !_isSelected;
            });
          }),
      body: Center(
          child: AnimatedContainer(
        width: _isSelected ? 400 : 100,
        height: _isSelected ? 400 : 50,
        curve: Curves.decelerate,
        alignment: _isSelected ? Alignment.bottomCenter : Alignment.topCenter,
        duration: const Duration(milliseconds: 1000),
        child: const AutoSizeText(
          'about_us_page',
          maxLines: 1,
          style: TextStyle(
            fontFamily: regularFont,
            fontSize: 100
          ),
          minFontSize: 10,
//          maxFontSize: 100,
          overflow: TextOverflow.visible,
        ),
      )),
    );
  }
}
