import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../common/route_info.dart';
import '../interfaces/i_app_router.dart';
import 'route_registrator.dart';

class AppRouteDelegate extends RouterDelegate<RouteInfo>
    with
        // ignore: prefer_mixin
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<RouteInfo>
    implements
        IAppRouter {
  AppRouteDelegate(this.registrator);

  final AppRouteRegistrator registrator;

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get navigator => navigatorKey!.currentState!;

  final routeStack = <RouteInfo>[];
  int routeStackIndex = -1;

  final heroController = HeroController();

  @override
  Widget build(BuildContext context) {
    Widget result = Navigator(
      key: navigatorKey,
      pages: routeStack
          .take(routeStackIndex + 1)
          .map(registrator.buildPage)
          .toList(),
      onPopPage: onPopPage,
      restorationScopeId: '#navigator',
      observers: [heroController],
    );

    assert(() {
      final theme = Theme.of(context);
      final style = theme.textTheme.bodySmall!;
      final styleIndexed = style.copyWith(color: theme.colorScheme.tertiary);
      result = Stack(
        alignment: Alignment.bottomLeft,
        children: [
          result,
          Material(
            type: MaterialType.transparency,
            child: IgnorePointer(
              child: DefaultTextStyle(
                style: style,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.left,
                child: ListView(
                  reverse: true,
                  children: routeStack.isEmpty
                      ? const []
                      : [
                          ...routeStack.reversed
                              .take(routeStack.length - routeStackIndex - 1)
                              .map((e) => Text(e.path)),
                          Text(routeStack[routeStackIndex].path,
                              style: styleIndexed),
                          ...routeStack.reversed
                              .skip(routeStack.length - routeStackIndex)
                              .map((e) => Text(e.path)),
                        ],
                ),
              ),
            ),
          ),
        ],
      );
      return true;
    }(), 'Add debugging route history stack overlay');

    return result;
  }

  bool onPopPage<T>(Route<T> route, T? result) {
    if (!route.didPop(result)) return false;
    goBack();
    return true;
  }

  @override
  Future<void> setInitialRoutePath(RouteInfo configuration) =>
      setNewRoutePath(registrator.initialRoute);

  @override
  Future<void> setNewRoutePath(RouteInfo configuration) {
    routeStackIndex++;
    routeStack
      ..removeRange(routeStackIndex, routeStack.length)
      ..add(configuration);
    notifyListeners();
    return SynchronousFuture(null);
  }

  @override
  Future<void> setRestoredRoutePath(RouteInfo configuration) =>
      setNewRoutePath(configuration);

  @override
  RouteInfo? get currentConfiguration =>
      routeStack.isNotEmpty ? routeStack[routeStackIndex] : null;

  @override
  void goBack() {
    if (routeStackIndex > 0) {
      routeStackIndex--;
      notifyListeners();
    }
  }

  @override
  Future<T> pending<T>(Future<T> future) {
    navigator.push(DialogRoute(
      barrierDismissible: false,
      barrierColor: Theme.of(navigator.context).brightness == Brightness.dark
          ? Colors.black.withOpacity(0.7)
          : Colors.white54,
      context: navigator.context,
      builder: (context) => const CircularProgressIndicator.adaptive(),
    ));
    future.whenComplete(navigator.pop).ignore();
    return future;
  }
}
