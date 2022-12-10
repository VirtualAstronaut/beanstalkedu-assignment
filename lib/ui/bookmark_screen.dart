import 'package:beanstalkedu_assignment/ui/components/article_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils.dart';

class BookmarkScreen extends ConsumerStatefulWidget {
  const BookmarkScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends ConsumerState<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarked'),
      ),
      body: ListView.builder(
        itemCount: Utils.box.length,
        itemBuilder: (context, index) {
          return ArticleContainer(
            articleModel: Utils.box.getAt(index),
            voidCallback: () => setState(() {}),
          );
        },
      ),
    );
  }
}
