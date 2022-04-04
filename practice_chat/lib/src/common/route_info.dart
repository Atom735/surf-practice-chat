import 'package:meta/meta.dart';

@immutable
abstract class RouteInfo {
  /// Implements only
  const RouteInfo._();

  String get path;
}

@immutable
class UnknownRouteInfo implements RouteInfo {
  const UnknownRouteInfo(this.path);

  @override
  final String path;
}

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
