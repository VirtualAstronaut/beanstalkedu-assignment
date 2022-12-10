import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'model/article_model.dart';

class Utils {
  static final Dio dio = Dio();
  static const baseUrl = "newsapi.org";
  static late Box box;
  static const flutterSecureStorage = FlutterSecureStorage();
  static initializeHiveAndKey() async {
    Hive.init((await getApplicationDocumentsDirectory()).path);
    Hive.registerAdapter(ArticleModelAdapter());
    box = await Hive.openBox('myBox');
    if (await Utils.flutterSecureStorage.containsKey(key: 'apiKey')) {
      apiKey = (await flutterSecureStorage.read(key: 'apiKey'))!;
    }
  }

  static String currentEndPoint = '/v2/top-headlines';
  static String everythingEndpoint = '/v2/everything';
  static String topHeadlinesEndPoint = '/v2/top-headlines';
  static String sourcesEndpoint = '/v2/top-headlines/sources';
  static String apiKey = '';
  static var globalNavigatorKey = GlobalKey<NavigatorState>();
}
