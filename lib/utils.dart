import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static final Dio dio = Dio();
  static const baseUrl = "newsapi.org";
  static String apiKey = '';
  static var globalNavigatorKey = GlobalKey<NavigatorState>();
}
