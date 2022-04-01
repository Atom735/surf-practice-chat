import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../pages/home_page.dart';

@immutable
class AppRouteParser extends RouteInformationParser<Page> {
  @literal
  const AppRouteParser();

  @override
  Future<Page> parseRouteInformation(RouteInformation routeInformation) =>
      SynchronousFuture(
        const HomePage(),
      );

  @override
  RouteInformation? restoreRouteInformation(Page configuration) {}
}
