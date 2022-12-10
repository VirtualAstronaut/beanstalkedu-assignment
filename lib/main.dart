import 'package:beanstalkedu_assignment/ui/news_screen.dart';
import 'package:beanstalkedu_assignment/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
              navigatorKey: Utils.globalNavigatorKey,
              theme: ThemeData(
                  colorSchemeSeed: Colors.green.shade500, useMaterial3: true),
              home: NewsScreen());
        },
      ),
    );
  }
}
