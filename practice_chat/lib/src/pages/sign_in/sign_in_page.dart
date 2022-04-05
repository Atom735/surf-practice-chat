import 'package:flutter/material.dart';

import 'sign_in_route_info.dart';
import 'sign_in_screen.dart';

class SignInPage extends MaterialPage {
  SignInPage(this.routeInfo)
      : super(
          child: const SignInScreen(),
          name: routeInfo.path,
          restorationId: routeInfo.path,
        );

  final SignInRouteInfo routeInfo;

  @override
  bool canUpdate(Page other) {
    assert(() {
      print('$this try to update by $other');
      return true;
    }(), 'debug printing');
    return super.canUpdate(other);
  }
}
