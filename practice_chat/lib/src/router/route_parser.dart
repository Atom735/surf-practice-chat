import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../common/route_info.dart';
import 'route_registrator.dart';

@immutable
class AppRouteParser extends RouteInformationParser<RouteInfo> {
  const AppRouteParser(this.registrator);

  final AppRouteRegistrator registrator;

  @override
  Future<RouteInfo> parseRouteInformation(RouteInformation routeInformation) =>
      SynchronousFuture(registrator.parseConfiguration(routeInformation));

  @override
  RouteInformation? restoreRouteInformation(RouteInfo configuration) =>
      RouteInformation(location: configuration.path);
}
