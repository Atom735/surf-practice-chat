import 'package:meta/meta.dart';

import '../../router/route_info.dart';

@immutable
class HomeRouteInfo implements RouteInfo {
  @literal
  const HomeRouteInfo();

  @override
  String get path => '/home';
}
