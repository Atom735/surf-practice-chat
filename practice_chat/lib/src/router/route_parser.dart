import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'route_info.dart';

@immutable
class AppRouteParser extends RouteInformationParser<RouteInfo> {
  @literal
  const AppRouteParser();

  @override
  Future<RouteInfo> parseRouteInformation(
      RouteInformation routeInformation) async {
    switch (routeInformation.location) {
      default:
        return UnknownRouteInfo(routeInformation.location ?? '');
    }
  }

  @override
  RouteInformation? restoreRouteInformation(RouteInfo configuration) =>
      RouteInformation(location: configuration.path);
}
