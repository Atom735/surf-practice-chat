import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Interface of [ISignUpWidgetModel].
abstract class ISignUpWidgetModel extends IWidgetModel {
  /// For implements only
  ISignUpWidgetModel._();

  FocusNode get focusLogin;
  TextEditingController get controllerLogin;
  ValueNotifier<String?> get errorLogin;

  FocusNode get focusPassword;
  TextEditingController get controllerPassword;
  ValueNotifier<String?> get errorPassword;

  ValueNotifier<String?> get errorOther;

  ThemeData get theme;

  void handleLoginDone([_]);
  void handleSubmit([_]);
  void handleSignIn([_]);
}
