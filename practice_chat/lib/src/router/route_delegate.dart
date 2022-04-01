import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'route_info.dart';

class AppRouteDelegate extends RouterDelegate<AppRouteInfo>
    with
        // ignore: prefer_mixin
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<AppRouteInfo> {
  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  final routeStack = <AppRouteInfo>[];

  @override
  Future<void> setNewRoutePath(AppRouteInfo configuration) {
    routeStack.add(configuration);
    notifyListeners();
    return SynchronousFuture(null);
  }

  @override
  Widget build(BuildContext context) {
    Widget result = Navigator(key: navigatorKey, pages: [], onPopPage: );

    return result;
  }
}
