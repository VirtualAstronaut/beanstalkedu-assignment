import 'dart:convert';

import 'package:beanstalkedu_assignment/core/providers/article_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final articleNotifierProvider =
    StateNotifierProvider<ArticleProvider, AsyncValue>(
  (ref) {
    return ArticleProvider(const AsyncData([]));
  },
);
final selectedCategoriesProvider = StateProvider<String>(
  (ref) => '',
);
final apiKeyProvider = StateProvider(
  (ref) => '',
);
final dateFilterProvider = StateProvider<List<DateTime>>((ref) => []);
