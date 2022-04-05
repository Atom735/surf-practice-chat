import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'route_info.dart';

abstract class IAppRouter {
  /// For implement only
  const IAppRouter._();

  static IAppRouter of(BuildContext context) => context.read<IAppRouter>();

  RouteInfo? getHistory([int i = 0]);

  void goBack([int i = 1]);

  void goNext([int i = 1]);

  Future<void> setNewRoutePath(RouteInfo configuration);

  RouteInfo? get currentConfiguration;

  void setPages(List<RouteInfo> pages);

  void dispose();

  Future<T> pending<T>(Future<T> future);
}
