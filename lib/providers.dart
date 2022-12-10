import 'dart:convert';

import 'package:beanstalkedu_assignment/core/providers/article_provider.dart';
import 'package:beanstalkedu_assignment/model/article_model.dart';
import 'package:beanstalkedu_assignment/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'providers.g.dart';

final themeDataProvider = StateProvider(
  (ref) {
    return ThemeData();
  },
);

final articleProvider =
    StateNotifierProvider<ArticleProvider, List<ArticleModel>>(
  (ref) => ArticleProvider(),
);

@riverpod
Future<List<ArticleModel>> _getArticles(GetArticlesRef ref,
    {required String query}) async {
  if (query.isEmpty) {
    return [];
  }
  final uri = Uri.https(Utils.baseUrl, '/v2/everything',
      {'q': query, 'apiKey': '0a9735a8a1e64c6f805859dbbfd00984'});
  final response = await http.get(uri);
  final articleList = <ArticleModel>[];
  final jsonBody = jsonDecode(response.body);

  if (response.statusCode == 200 && jsonBody['status'] == 'ok') {
    for (var i = 0; i < jsonBody['articles']?.length; i++) {
      articleList.add(ArticleModel.fromMap(jsonBody['articles'][i]));
    }
  } else {
    if (Utils.globalNavigatorKey.currentContext != null) {
      ScaffoldMessenger.of(Utils.globalNavigatorKey.currentContext!)
          .showSnackBar(SnackBar(
        content: Text(jsonBody['message']),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 10),
        dismissDirection: DismissDirection.down,
      ));
    }
    throw Exception();
  }

  return articleList;
}
