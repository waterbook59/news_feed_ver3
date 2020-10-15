import 'package:flutter/material.dart';
import 'package:newsfeedver3/data_models/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({this.article});
  final Article article;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(article.title),),
        body: WebView(
          initialUrl: article.url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
