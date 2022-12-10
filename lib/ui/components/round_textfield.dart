import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoundTextField extends ConsumerWidget {
  const RoundTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.onChanged,
  });
  final String labelText;
  final TextEditingController controller;
  final void Function(String value)? onChanged;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: labelText,
          prefixIcon: Icon(Icons.search, color: colorScheme.onPrimaryContainer),
          labelStyle: const TextStyle(),
          fillColor: colorScheme.primaryContainer,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide())),
    );
  }
}
