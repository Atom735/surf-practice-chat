import 'package:flutter/material.dart';

import 'sign_up_route_info.dart';
import 'sign_up_screen.dart';

class SignUpPage extends MaterialPage {
  SignUpPage(this.routeInfo)
      : super(
          child: const SignUpScreen(),
          name: routeInfo.path,
          restorationId: routeInfo.path,
        );

  final SignUpRouteInfo routeInfo;

  @override
  bool canUpdate(Page other) {
    assert(() {
      print('$this try to update by $other');
      return true;
    }(), 'debug printing');
    return super.canUpdate(other);
  }
}
