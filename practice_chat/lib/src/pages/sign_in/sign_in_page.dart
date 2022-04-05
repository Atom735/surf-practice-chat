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
}
