import 'package:meta/meta.dart';

@immutable
class AppRouteInfo {
  @literal
  const AppRouteInfo(this.name, this.args);

  final String name;
  final Object? args;
}
