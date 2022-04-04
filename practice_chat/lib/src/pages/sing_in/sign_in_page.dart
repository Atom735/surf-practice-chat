import 'package:flutter/material.dart';

import 'sign_in_route_info.dart';
import 'sign_in_screen.dart';

class SignInPage extends MaterialPage {
  SignInPage()
      : super(
          child: const SignInScreen(),
          name: const SignInRouteInfo().path,
          restorationId: const SignInRouteInfo().path,
        );
}
