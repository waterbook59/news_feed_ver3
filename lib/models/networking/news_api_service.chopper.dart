// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$NewsApiService extends NewsApiService {
  _$NewsApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = NewsApiService;

  @override
  Future<Response<dynamic>> getHeadLineNews(
      {String country = 'ja',
      int pageSize = 10,
      String apiKey = NewsApiService.apiKey}) {
    final $url = '/top-headlines';
    final $params = <String, dynamic>{
      'country': country,
      'pageSize': pageSize,
      'apiKey': apiKey
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getKeywordNews(
      {String country = 'ja',
      String q,
      int pageSize = 30,
      String apiKey = NewsApiService.apiKey}) {
    final $url = '/top-headlines';
    final $params = <String, dynamic>{
      'country': country,
      'q': q,
      'pageSize': pageSize,
      'apiKey': apiKey
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCategoryNews(
      {String country = 'ja',
      String category,
      int pageSize = 30,
      String apiKey = NewsApiService.apiKey}) {
    final $url = '/top-headlines';
    final $params = <String, dynamic>{
      'country': country,
      'category': category,
      'pageSize': pageSize,
      'apiKey': apiKey
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }
}
