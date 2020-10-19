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
        //ここ入れないとHeadLineItemで使うとき拡大しない！！！
        fit: BoxFit.cover,

        //imageBuilder使うとここでさらにカスタマイズできる(例えば丸く)
        //width,height指定しないと画像出ないよ
//        imageBuilder: (context,imageProvider)=> Container(
//          width: 80,
//          height: 80,
//          decoration: BoxDecoration(
//            shape: BoxShape.circle,
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
