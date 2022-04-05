import 'package:flutter/material.dart';

import 'home_route_info.dart';
import 'home_screen.dart';

class HomePage extends MaterialPage {
  HomePage(this.routeInfo)
      : super(
          child: const HomeScreen(),
          name: routeInfo.path,
          restorationId: routeInfo.path,
        );

  final HomeRouteInfo routeInfo;
}
