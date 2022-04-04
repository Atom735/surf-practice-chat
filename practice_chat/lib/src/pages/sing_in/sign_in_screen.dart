import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'sign_in_wm_factory.dart';
import 'sign_in_wm_interface.dart';

class SignInScreen extends ElementaryWidget<ISignInWidgetModel> {
  const SignInScreen({
    Key? key,
    WidgetModelFactory wmFactory = signInWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISignInWidgetModel wm) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
