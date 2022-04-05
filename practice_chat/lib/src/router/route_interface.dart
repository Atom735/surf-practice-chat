import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'route_info.dart';

abstract class IAppRouter {
  /// For implement only
  const IAppRouter._();

  static IAppRouter of(BuildContext context) => context.read<IAppRouter>();

  void goBack();

  Future<void> setNewRoutePath(RouteInfo configuration);

  void setPages(List<RouteInfo> pages);

  void dispose();

  Future<T> pending<T>(Future<T> future);
}
