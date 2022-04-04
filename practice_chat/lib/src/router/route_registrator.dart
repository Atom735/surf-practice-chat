import 'package:flutter/widgets.dart';

import '../common/route_info.dart';
import '../pages/unknown_page.dart';

typedef PageBuilder<T extends RouteInfo> = Page Function(T routeInfo);
typedef RouteInfoParser<T extends RouteInfo> = T Function(
    RouteInformation configuration);

class AppRouteRegistrator {
  AppRouteRegistrator(this.initialRoute);

  final _pageBuilders = <Type, PageBuilder>{};
  final _routeParsers = <Pattern, RouteInfoParser>{};

  final RouteInfo initialRoute;

  bool isRegistered<T extends RouteInfo>() => _pageBuilders.containsKey(T);

  void register<T extends RouteInfo>({
    required PageBuilder<T> builder,
    required Pattern pattern,
    required RouteInfoParser<T> parser,
  }) {
    assert(!_pageBuilders.containsKey(T), 'that route type registred');
    assert(!_routeParsers.containsKey(pattern), 'that route pattern registred');
    _pageBuilders[T] = (info) => builder(info as T);
    _routeParsers[pattern] = parser;
  }

  Page buildPage(RouteInfo routeInfo) {
    final builder = _pageBuilders[routeInfo.runtimeType] ?? UnknownPage.new;
    return builder(routeInfo);
  }

  RouteInfo parseConfiguration(RouteInformation routeInformation) {
    final path = routeInformation.location;
    if (path == null) return const UnknownRouteInfo('');
    for (final parser in _routeParsers.entries) {
      if (path.startsWith(parser.key)) {
        return parser.value(routeInformation);
      }
    }
    return UnknownRouteInfo(path);
  }
}
