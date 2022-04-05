import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../../interfaces/i_auth_service.dart';
import 'sign_up_model.dart';
import 'sign_up_screen.dart';
import 'sign_up_wm_interface.dart';

/// Widget Model for [SignUpScreen].
class SignUpWidgetModel extends WidgetModel<SignUpScreen, SignUpModel>
    implements ISignUpWidgetModel {
  SignUpWidgetModel({
    required SignUpModel model,
  }) : super(model);

  @override
  final focusLogin = FocusNode();
  @override
  final controllerLogin = TextEditingController();
  @override
  final errorLogin = ValueNotifier<String?>(null);

  @override
  final focusPassword = FocusNode();
  @override
  final controllerPassword = TextEditingController();
  @override
  final errorPassword = ValueNotifier<String?>(null);

  @override
  final errorOther = ValueNotifier<String?>(null);

  @override
  late ThemeData theme;

  @override
  void handleLoginDone([_]) {
    focusPassword.requestFocus();
  }

  @override
  void handleSubmit([_]) {
    if (errorLogin.value != null || errorPassword.value != null) {
      return;
    }
    errorOther.value = null;
    model.signUp(controllerLogin.text, controllerPassword.text);
  }

  @override
  void handleSignUp([_]) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unimplemnted')),
    );
  }

  @override
  void onErrorHandle(Object error) {
    if (error is AuthErrorUnregisteredUser) {
      errorLogin.value = 'Error: unregistred user';
      focusLogin.requestFocus();
    } else if (error is AuthErrorIncorrectPassword) {
      errorPassword.value = 'Error: incorrect password';
      focusPassword.requestFocus();
    } else {
      errorOther.value = error.toString();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    controllerLogin.addListener(_resetErrorLogin);
    controllerPassword.addListener(_resetErrorPassword);
  }

  @override
  void dispose() {
    controllerLogin.dispose();
    controllerPassword.dispose();
    errorLogin.dispose();
    errorPassword.dispose();
    focusLogin.dispose();
    focusPassword.dispose();
    super.dispose();
  }

  void _resetErrorLogin() {
    errorLogin.value = null;
  }

  void _resetErrorPassword() {
    errorPassword.value = null;
  }
}
