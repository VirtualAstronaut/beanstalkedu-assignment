import 'package:beanstalkedu_assignment/ui/bookmark_screen.dart';
import 'package:beanstalkedu_assignment/ui/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  var navigationIndex = 0;
  final screens = [NewsScreen(), BookmarkScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[navigationIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            navigationIndex = value;
            setState(() {});
          },
          currentIndex: navigationIndex,
          items: const [
            BottomNavigationBarItem(label: 'News', icon: Icon(Icons.newspaper)),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark), label: 'Bookmarks')
          ]),
    );
  }
}
