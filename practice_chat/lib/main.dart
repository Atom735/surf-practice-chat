import 'package:flutter/material.dart';

import 'src/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.light,
        color: Colors.amber,
        theme: ThemeData.from(
          colorScheme: const ColorScheme.light(),
          textTheme: Typography.material2018().englishLike,
        ),
        home: const HomeScreenWidget(),
      );
}
