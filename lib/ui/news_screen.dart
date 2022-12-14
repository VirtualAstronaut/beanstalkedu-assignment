import 'dart:async';

import 'package:beanstalkedu_assignment/providers.dart';
import 'package:beanstalkedu_assignment/ui/components/article_container.dart';
import 'package:beanstalkedu_assignment/ui/components/round_textfield.dart';
import 'package:beanstalkedu_assignment/ui/date_picker_dialog.dart';
import 'package:beanstalkedu_assignment/ui/category_filter_dialog.dart';
import 'package:beanstalkedu_assignment/ui/save_api_key_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../utils.dart';

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
    setupKey();
  }

  void setupKey() async {
    if (await Utils.flutterSecureStorage.containsKey(key: 'apiKey')) {
      ref.read(apiKeyProvider.notifier).state =
          (await Utils.flutterSecureStorage.read(key: 'apiKey'))!;
    }
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
              child: RoundTextField(
                labelText:
                    'Search ${Utils.currentEndPoint == Utils.everythingEndpoint ? 'Everything' : 'Headlines'}',
                controller: searchController,
                onChanged: (value) {
                  if (value.isEmpty) {
                    return;
                  }
                  if (timer?.isActive ?? false) timer?.cancel();
                  timer = Timer.periodic(const Duration(milliseconds: 500),
                      (timer) {
                    getData();
                    timer.cancel();
                  });
                },
              )),
          bottom: PreferredSize(
              preferredSize: Size(100.w, kToolbarHeight),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: categorySelectCallback,
                      style: IconButton.styleFrom(
                        backgroundColor:
                            ref.watch(selectedCategoriesProvider).isEmpty
                                ? null
                                : colorScheme.primaryContainer,
                      ),
                      icon: Icon(Icons.filter_alt_outlined,
                          color: colorScheme.onPrimaryContainer)),
                  IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: ref.watch(dateFilterProvider).isEmpty
                            ? null
                            : colorScheme.primaryContainer,
                      ),
                      onPressed: dateFilterCallback,
                      icon: Icon(
                          ref.watch(dateFilterProvider).isEmpty
                              ? Icons.date_range_outlined
                              : Icons.date_range_rounded,
                          color: colorScheme.onPrimaryContainer)),
                  TextButton(
                      onPressed: () {
                        if (Utils.currentEndPoint == Utils.everythingEndpoint) {
                          Utils.currentEndPoint = Utils.topHeadlinesEndPoint;
                        } else {
                          Utils.currentEndPoint = Utils.everythingEndpoint;
                        }
                        getData();
                        setState(() {});
                      },
                      child: Text(
                          Utils.currentEndPoint == Utils.everythingEndpoint
                              ? 'Everything'
                              : 'Headlines'))
                ],
              )),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const SaveAPIKeyDialog();
                    },
                  );
                  setState(() {});
                },
                icon: Icon(Icons.more_vert))
          ],
        ),
        body: ref.watch(apiKeyProvider).isEmpty
            ? const Center(child: Text('Please Add API Key From 3 Dot Menu'))
            : articleProvider.whenOrNull(
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

  void dateFilterCallback() async {
    final didChoiceChange = await showDialog(
        context: context,
        builder: (context) {
          return const FromToDateDialog();
        });
    if (didChoiceChange != null && didChoiceChange) {
      getData();
    }
  }

  void categorySelectCallback() async {
    final didSelect = await showDialog(
        context: context,
        builder: (context) {
          return const CategoryFilterDialog();
        });
    if (didSelect != null && didSelect) {
      getData();
    }
  }

  void getData() {
    final fromToDates = ref.read(dateFilterProvider);
    final selectedCategory = ref.read(selectedCategoriesProvider);
    ref.read(articleNotifierProvider.notifier).getSearchResults(
        searchController.text,
        category: selectedCategory,
        fromDate: fromToDates.isNotEmpty ? fromToDates.first : null,
        toDate: fromToDates.isNotEmpty ? fromToDates.last : null);
  }
}
