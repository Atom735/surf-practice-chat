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
