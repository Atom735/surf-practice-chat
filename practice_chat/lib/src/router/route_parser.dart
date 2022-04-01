import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'route_info.dart';

@immutable
class AppRouteParser extends RouteInformationParser<AppRouteInfo> {
  @literal
  const AppRouteParser();

  @override
  Future<AppRouteInfo> parseRouteInformation(
          RouteInformation routeInformation) =>
      SynchronousFuture(
        AppRouteInfo(
          routeInformation.location ?? '',
          routeInformation.state,
        ),
      );

  @override
  RouteInformation? restoreRouteInformation(AppRouteInfo configuration) =>
      RouteInformation(
        location: configuration.name,
        state: configuration.args,
      );
}
