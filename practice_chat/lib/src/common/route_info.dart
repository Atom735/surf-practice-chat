import 'package:meta/meta.dart';

@immutable
abstract class RouteInfo {
  const RouteInfo();

  String get path;

  @override
  String toString() => path;
}

@immutable
class UnknownRouteInfo extends RouteInfo {
  const UnknownRouteInfo(this.path);

  @override
  final String path;
}
/*
@immutable
class HomeRouteInfo implements RouteInfo {
  @literal
  const HomeRouteInfo();

  @override
  String get path => '/';
}

@immutable
class SignInRouteInfo implements RouteInfo {
  @literal
  const SignInRouteInfo();

  @override
  String get path => '/login';
}

@immutable
class SignUpRouteInfo implements RouteInfo {
  @literal
  const SignUpRouteInfo();

  @override
  String get path => '/singup';
}
*/
