import 'package:flutter/material.dart';
import 'package:dory/components/dory_themes.dart';
import 'package:dory/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: DoryThemes.lightTheme,
        home: const HomePage(),
        builder: (context, child) => MediaQuery(
            child: child!,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0)));
  }
}
