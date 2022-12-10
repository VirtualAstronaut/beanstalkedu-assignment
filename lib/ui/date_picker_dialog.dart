import 'package:beanstalkedu_assignment/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FromToDateDialog extends ConsumerStatefulWidget {
  const FromToDateDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FromToDialogState();
}

class _FromToDialogState extends ConsumerState<FromToDateDialog> {
  DateTime toDate = DateTime.now();
  DateTime? fromDate;

  @override
  void initState() {
    super.initState();
    final dates = ref.read(dateFilterProvider);
    if (dates.isNotEmpty) {
      fromDate = dates.first;
      toDate = dates.last;
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final dateFilter = ref.read(dateFilterProvider.notifier);
    return AlertDialog(
      title: const Text('Please Select Date Range'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('From Date'),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(elevation: 0),
                  onPressed: () async {
                    fromDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    setState(() {});
                  },
                  icon: const Icon(Icons.date_range),
                  label: Text(fromDate != null
                      ? DateFormat('dd/MM/yyyy').format(fromDate!)
                      : "Select Date")),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('To Date'),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(elevation: 0),
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    toDate = selectedDate ?? toDate;
                    setState(() {});
                  },
                  icon: const Icon(Icons.date_range),
                  label: Text(DateFormat('dd/MM/yyyy').format(toDate))),
            ],
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (fromDate != null) {
                dateFilter.state = [fromDate!, toDate];
              }
              Navigator.pop(context, true);
            },
            child: const Text('OK')),
        TextButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            child: const Text('Cancel')),
        if (ref.read(dateFilterProvider).isNotEmpty)
          TextButton(
              onPressed: () {
                dateFilter.state = [];
                Navigator.pop(context, true);
              },
              child: const Text('Clear Date Filter')),
      ],
    );
  }
}
