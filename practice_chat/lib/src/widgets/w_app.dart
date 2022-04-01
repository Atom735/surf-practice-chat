import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../router/route_delegate.dart';
import '../router/route_parser.dart';
import '../theme/theme_color_schemes.dart';
import '../theme/theme_data.dart';
import 'w_background.dart';
import 'w_debugger.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late final AppRouteDelegate routerDelegate;

  @override
  void initState() {
    super.initState();
    routerDelegate = AppRouteDelegate();
  }

  @override
  void dispose() {
    routerDelegate.dispose();
    super.dispose();
  }

  Widget builder(BuildContext context, Widget? child) => Stack(
        fit: StackFit.expand,
        children: [
          const BackgroundWidget(),
          if (child != null) child,
          if (kDebugMode) const DebuggerWidget(),
        ],
      );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Flutter Chat Practice',
        themeMode: ThemeMode.light,
        color: themeColorSchemeSeed,
        theme: themeDataLight,
        darkTheme: themeDataDark,
        builder: builder,
        routerDelegate: routerDelegate,
        routeInformationParser: const AppRouteParser(),
      );
}
