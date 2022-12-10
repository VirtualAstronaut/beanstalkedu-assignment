import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static final Dio dio = Dio();
  static const baseUrl = "newsapi.org";

  static String currentEndPoint = '/v2/top-headlines';
  static String everythingEndpoint = '/v2/everything';
  static String topHeadlinesEndPoint = '/v2/top-headlines';
  static String sourcesEndpoint = '/v2/top-headlines/sources';
  static String apiKey = 'cbc5feef5d1f4112ac8d99d7b4f405fd';
  static var globalNavigatorKey = GlobalKey<NavigatorState>();
}
