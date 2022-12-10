import 'dart:convert';
import 'dart:developer';

import 'package:beanstalkedu_assignment/model/article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../utils.dart';

class ArticleProvider extends StateNotifier<AsyncValue<List<ArticleModel>>> {
  ArticleProvider(super.state);

  getSearchResults(String query,
      {List<String>? domains,
      DateTime? fromDate,
      DateTime? toDate,
      String? category}) async {
    state = const AsyncLoading();
    state = AsyncValue.data(
        await _getSearchData(query, domains, fromDate, toDate, category));
  }

  _getSearchData(String query, List<String>? domains, DateTime? fromDate,
      DateTime? toDate, String? category) async {
    final uri = Uri.https(Utils.baseUrl, Utils.currentEndPoint, {
      'to': toDate?.toIso8601String(),
      'from': fromDate?.toIso8601String(),
      'domains': domains?.toString(),
      'q': query,
      'category': category,
      'apiKey': 'cbc5feef5d1f4112ac8d99d7b4f405fd'
    });
    log(uri.toString());
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
    }
    return articleList;
  }
}
