import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../router/route_delegate.dart';
import '../router/route_interface.dart';
import '../router/route_parser.dart';
import '../router/route_registrator.dart';
import '../theme/theme_color_schemes.dart';
import '../theme/theme_data.dart';
import 'w_background.dart';
import 'w_debugger.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({
    this.providers = const [],
    Key? key,
  }) : super(key: key);

  final List<SingleChildWidget> providers;

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  AppRouteParser? routeParser;

  @override
  void didChangeDependencies() {
    routeParser ??= AppRouteParser(AppRouteRegistrator.of(context));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget builder(BuildContext context, Widget? child) {
    final result = Stack(
      fit: StackFit.expand,
      children: [
        const BackgroundWidget(),
        if (child != null) ScaffoldMessenger(child: child),
        if (kDebugMode) const DebuggerWidget(),
      ],
    );
    if (widget.providers.isEmpty) return result;
    return MultiProvider(
      providers: widget.providers,
      child: result,
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Flutter Chat Practice',

        // themeMode: ThemeMode.system,
        color: themeColorSchemeSeed,
        theme: themeDataLight,
        darkTheme: themeDataDark,
        builder: builder,
        routerDelegate: IAppRouter.of(context) as AppRouteDelegate,
        routeInformationParser: routeParser!,
        restorationScopeId: '#app',
      );
}
