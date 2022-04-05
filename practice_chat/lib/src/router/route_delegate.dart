import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'route_info.dart';
import 'route_interface.dart';
import 'route_pending.dart';
import 'route_registrator.dart';

class AppRouteDelegate extends RouterDelegate<RouteInfo>
    with
        // ignore: prefer_mixin
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<RouteInfo>
    implements
        IAppRouter {
  AppRouteDelegate(this.registrator) {
    _pendingsCounter.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _pendingsCounter
      ..removeListener(notifyListeners)
      ..dispose();
    super.dispose();
  }

  Provider<IAppRouter> get provider {
    assert(() {
      final previous = Provider.debugCheckInvalidValueType;
      Provider.debugCheckInvalidValueType = <T>(value) {
        if (T == IAppRouter) return;
        previous?.call<T>(value);
      };
      return true;
    }(), 'disable warning for listnabel provided value');
    return Provider<IAppRouter>(
      create: (context) => this,
      dispose: (context, service) => service.dispose(),
    );
  }

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
      pages: [
        ...routeStack.take(routeStackIndex + 1).map(registrator.buildPage),
        if (_pendingsCounter.value > 0) const AppRoutePendingPage(),
      ],
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
  void goBack([int i = 1]) {
    assert(i > 0, 'cant go to negative back in history');
    if (routeStackIndex >= i) {
      routeStackIndex -= i;
      notifyListeners();
    } else if (routeStackIndex > 0) {
      routeStackIndex = 0;
      notifyListeners();
    }
  }

  @override
  void goNext([int i = 1]) {
    assert(i > 0, 'cant go to negative next in history');
    if (routeStackIndex + i < routeStack.length) {
      routeStackIndex += i;
      notifyListeners();
    } else if (routeStackIndex + 1 != routeStack.length) {
      routeStackIndex = routeStack.length - 1;
      notifyListeners();
    }
  }

  @override
  void setPages(List<RouteInfo> pages) {
    routeStack
      ..clear()
      ..addAll(pages);
    routeStackIndex = routeStack.length - 1;
    notifyListeners();
  }

  @override
  RouteInfo? getHistory([int i = 0]) {
    i = routeStackIndex - i;
    if (i >= 0 && i < routeStack.length) return routeStack[i];
    return null;
  }

  final _pendingsCounter = ValueNotifier(0);
  void _pendingOutFunc() => _pendingsCounter.value--;
  var _pendingsFuncsDebugsCount = 0;
  final _pendingsFuncsDebugsFlags = <int>{};

  @override
  void Function() pending() {
    _pendingsCounter.value++;
    var out = _pendingOutFunc;
    assert(() {
      final i = _pendingsFuncsDebugsCount++;
      _pendingsFuncsDebugsFlags.add(i);
      out = () {
        assert(
          _pendingsFuncsDebugsFlags.remove(i),
          'pendigns must call only once',
        );
        _pendingOutFunc();
      };
      return true;
    }(), 'debug pending funcs');

    return out;
  }
}
