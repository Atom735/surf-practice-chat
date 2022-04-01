import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'i_router.dart';

class AppRouteDelegate extends RouterDelegate<Page>
    with
        // ignore: prefer_mixin
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<Page>
    implements
        IAppRouter {
  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  final routeStack = <Page>[];
  int routeStackIndex = -1;

  @override
  Widget build(BuildContext context) {
    final result = Navigator(
      key: navigatorKey,
      pages: routeStack.sublist(0, routeStackIndex + 1),
      onPopPage: onPopPage,
      restorationScopeId: 'navigator',
    );

    return result;
  }

  bool onPopPage<T>(Route<T> route, T? result) {
    if (!route.didPop(result)) return false;
    goBack();
    return true;
  }

  @override
  Future<void> setInitialRoutePath(Page configuration) =>
      setNewRoutePath(configuration);

  @override
  Future<void> setNewRoutePath(Page configuration) {
    routeStackIndex++;
    routeStack
      ..removeRange(routeStackIndex, routeStack.length)
      ..add(configuration);
    notifyListeners();
    return SynchronousFuture(null);
  }

  @override
  Future<void> setRestoredRoutePath(Page configuration) =>
      setNewRoutePath(configuration);

  @override
  void openPage(Page route) => setNewRoutePath(route);

  @override
  void goBack() {
    if (routeStackIndex > 0) {
      routeStackIndex--;
      notifyListeners();
    }
  }
}
