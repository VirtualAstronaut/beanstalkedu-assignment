import 'dart:async';
import 'dart:developer';

import 'package:beanstalkedu_assignment/providers.dart';
import 'package:beanstalkedu_assignment/ui/article_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class NewsScreen extends ConsumerStatefulWidget {
  const NewsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewsScreenState();
}

class _NewsScreenState extends ConsumerState<NewsScreen> {
  var searchController = TextEditingController();
  DateTime? toDate;
  DateTime? fromDate;
  @override
  void initState() {
    super.initState();
  }

  Timer? timer;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final articleProvider = ref.watch(articleNotifierProvider);
    return Scaffold(
        backgroundColor: colorScheme.background,
        appBar: AppBar(
          title: SizedBox(
            height: 50,
            width: 80.w,
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                if (value.isEmpty) {
                  return;
                }
                if (timer?.isActive ?? false) timer?.cancel();
                timer =
                    Timer.periodic(const Duration(milliseconds: 500), (timer) {
                  ref
                      .watch(articleNotifierProvider.notifier)
                      .getSearchResults(value);
                  timer.cancel();
                });
              },
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'Search Everything',
                  prefixIcon:
                      Icon(Icons.search, color: colorScheme.onPrimaryContainer),
                  labelStyle: const TextStyle(),
                  fillColor: colorScheme.primaryContainer,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide())),
            ),
          ),
          bottom: PreferredSize(
              preferredSize: Size(100.w, kToolbarHeight),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.filter_alt_outlined,
                          color: colorScheme.onPrimaryContainer)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.date_range,
                          color: colorScheme.onPrimaryContainer))
                ],
              )),
        ),
        body: articleProvider.whenOrNull(
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          error: (error, stackTrace) {
            return Container();
          },
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ArticleContainer(articleModel: data[index]);
              },
            );
          },
        ));
  }
}
