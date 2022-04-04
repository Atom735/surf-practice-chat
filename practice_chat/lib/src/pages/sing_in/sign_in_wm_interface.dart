import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Interface of [ISignInWidgetModel].
abstract class ISignInWidgetModel extends IWidgetModel {
  /// For implements only
  ISignInWidgetModel._();

  FocusNode get focusLogin;
  TextEditingController get controllerLogin;
  ValueNotifier<String?> get errorLogin;

  FocusNode get focusPassword;
  TextEditingController get controllerPassword;
  ValueNotifier<String?> get errorPassword;

  ThemeData get theme;

  void handleLoginDone([_]);
  void handleSubmit([_]);
  void handleSignUp([_]);
}
