import 'package:meta/meta.dart';

import '../../common/route_info.dart';

@immutable
class SignInRouteInfo implements RouteInfo {
  @literal
  const SignInRouteInfo();

  @override
  String get path => '/login';
}
