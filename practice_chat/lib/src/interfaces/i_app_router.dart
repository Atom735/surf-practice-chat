import '../common/route_info.dart';

abstract class IAppRouter {
  /// For implement only
  const IAppRouter._();

  void goBack();

  Future<void> setNewRoutePath(RouteInfo configuration);

  void dispose();

  Future<T> pending<T>(Future<T> future);
}
