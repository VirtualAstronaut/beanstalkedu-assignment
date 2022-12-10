import 'dart:async';

import 'package:beanstalkedu_assignment/providers.dart';
import 'package:beanstalkedu_assignment/ui/components/round_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CategoryFilterDialog extends ConsumerStatefulWidget {
  const CategoryFilterDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoryFilterDialogState();
}

class _CategoryFilterDialogState extends ConsumerState<CategoryFilterDialog> {
  String? selectedCategory;
  @override
  void initState() {
    super.initState();
    selectedCategory = ref.read(selectedCategoriesProvider);
  }

  final listOfCategories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];

  Timer? timer;
  @override
  Widget build(
    BuildContext context,
  ) {
    return AlertDialog(
      title: const Text('Please Select Source Category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30.h,
            width: 100.w,
            child: ListView.builder(
              itemCount: listOfCategories.length,
              itemBuilder: (context, index) {
                return RadioListTile(
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: listOfCategories[index],
                  title: Text(listOfCategories[index][0].toUpperCase() +
                      listOfCategories[index].substring(1)),
                  groupValue: selectedCategory,
                  onChanged: (value) {
                    selectedCategory = value;
                    setState(() {});
                  },
                );
              },
            ),
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              bool didSelect = false;
              if (selectedCategory != null) {
                ref.read(selectedCategoriesProvider.notifier).state =
                    selectedCategory!;
                didSelect = true;
              }
              Navigator.pop(context, didSelect);
            },
            child: const Text('OK')),
        TextButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            child: const Text('Cancel')),
        if (ref.read(selectedCategoriesProvider).isNotEmpty)
          TextButton(
              onPressed: () {
                ref.read(selectedCategoriesProvider.notifier).state = '';
                Navigator.pop(context, true);
              },
              child: const Text('Clear Filter')),
      ],
    );
  }
}
