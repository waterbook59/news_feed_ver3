import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsfeedver3/data_models/article.dart';

class ArticleImage extends StatelessWidget {
  const ArticleImage({this.imageUrl});
  final String imageUrl;



  @override
  Widget build(BuildContext context) {
    //urlがnull、空文字、httpから始まってない場合の条件追加
    final isValidUrl = imageUrl.startsWith('http');
    if(imageUrl== null ||imageUrl==''|| !isValidUrl) {
      return const Icon(Icons.broken_image);
    }else{
      return CachedNetworkImage(
        imageUrl: imageUrl,
        //todo imageBuilder使うと画像出ないので使い方確認した方が良い
//        imageBuilder: (context,imageProvider)=> Container(
//          decoration: BoxDecoration(
//            image: DecorationImage(
//              image: imageProvider,
//              fit: BoxFit.cover,
//            ),
//          ),
//        ),
        placeholder: (context,url)=>const CircularProgressIndicator(),
        errorWidget: (context,url,error)=>const Icon(Icons.error),
      );
    }


  }
}
