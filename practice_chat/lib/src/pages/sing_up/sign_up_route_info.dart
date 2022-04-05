import 'package:meta/meta.dart';

import '../../common/route_info.dart';

@immutable
class SignUpRouteInfo implements RouteInfo {
  @literal
  const SignUpRouteInfo();

  @override
  String get path => '/login';
}
