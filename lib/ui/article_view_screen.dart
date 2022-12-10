import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../model/article_model.dart';

class ArticleViewScreen extends ConsumerStatefulWidget {
  const ArticleViewScreen({super.key, required this.articleModel});
  final ArticleModel articleModel;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ArticleViewScreenState();
}

class _ArticleViewScreenState extends ConsumerState<ArticleViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.articleModel.title,
          style: TextStyle(fontSize: 17),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: WebView(
        initialUrl: widget.articleModel.url,
      ),
    );
  }
}
