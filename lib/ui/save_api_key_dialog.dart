import 'package:beanstalkedu_assignment/ui/components/round_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils.dart';

class SaveAPIKeyDialog extends ConsumerStatefulWidget {
  const SaveAPIKeyDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SaveAPIKeyDialogState();
}

class _SaveAPIKeyDialogState extends ConsumerState<SaveAPIKeyDialog> {
  var apiKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Save API Key'),
      content: RoundTextField(
        labelText: 'Enter API Key',
        controller: apiKeyController,
        showIcon: false,
        onChanged: (String value) {},
      ),
      actions: [
        TextButton(
            onPressed: () async {
              await Utils.flutterSecureStorage
                  .write(key: 'apiKey', value: apiKeyController.text);
              Utils.apiKey = apiKeyController.text;
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
      ],
    );
  }
}
