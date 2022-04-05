import 'package:meta/meta.dart';

import '../../common/route_info.dart';

@immutable
class HomeRouteInfo implements RouteInfo {
  @literal
  const HomeRouteInfo();

  @override
  String get path => '/home';
}
