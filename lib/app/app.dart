import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poc_isar/app/data/local/isar/providers.dart';
import 'package:poc_isar/app/feature/utils/app_theme.dart';

import 'feature/home/home_page.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(isarDbProvider);
    return MaterialApp(
      title: 'POC Isar',
      theme: AppTheme.themeData,
      routes: {
        '/': (_) => const HomePage(),
      },
    );
  }
}
