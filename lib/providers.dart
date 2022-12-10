import 'dart:convert';

import 'package:beanstalkedu_assignment/core/providers/article_provider.dart';
import 'package:beanstalkedu_assignment/model/article_model.dart';
import 'package:beanstalkedu_assignment/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final articleNotifierProvider =
    StateNotifierProvider<ArticleProvider, AsyncValue>(
  (ref) {
    return ArticleProvider(const AsyncData([]));
  },
);

final dateFilterProvider = StateProvider<List<DateTime>>((ref) => []);
