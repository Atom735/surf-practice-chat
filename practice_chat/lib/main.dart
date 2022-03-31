import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(const MyApp());
}

class ScreenBackgroundWidget extends StatelessWidget {
  const ScreenBackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Image.asset(
        'assets/images/bg.png',
        fit: BoxFit.cover,
      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget builder(BuildContext context, Widget? child) => Stack(
        fit: StackFit.expand,
        children: [
          const ScreenBackgroundWidget(),
          if (child != null) child,
        ],
      );

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
        builder: builder,
      );
}
