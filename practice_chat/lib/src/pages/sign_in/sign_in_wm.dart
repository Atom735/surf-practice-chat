import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../../services/auth/auth_errors.dart';
import '../../services/auth/auth_states.dart';
import 'sign_in_model.dart';
import 'sign_in_screen.dart';
import 'sign_in_wm_interface.dart';

/// Widget Model for [SignInScreen].
class SignInWidgetModel extends WidgetModel<SignInScreen, SignInModel>
    implements ISignInWidgetModel {
  SignInWidgetModel({
    required SignInModel model,
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
    model.signIn(controllerLogin.text, controllerPassword.text);
  }

  @override
  void handleSignUp([_]) {
    model.handleSignUp();
  }

  @override
  void onErrorHandle(Object error) {
    errorOther.value = error.toString();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
  }

  late StreamSubscription _ssAuthState;

  void _authStateListner(AuthState state) {
    errorOther.value = null;
    if (state is AuthStateError) {
      final error = state.error;
      if (error is AuthErrorUnregisteredUser) {
        errorLogin.value = error.message;
      } else if (error is AuthErrorIncorrectPassword) {
        errorPassword.value = error.message;
      } else {
        errorOther.value = error.toString();
      }
    } else if (state is AuthStateRegistered) {
      controllerLogin.text = state.username;
      controllerPassword.text = '';
      focusPassword.requestFocus();
    } else if (state is AuthStateUnauthorized) {
      controllerLogin.text = state.username;
      controllerPassword.text = '';
      if (state.username.isNotEmpty) {
        focusPassword.requestFocus();
      } else {
        focusLogin.requestFocus();
      }
    }
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    controllerLogin.addListener(_resetErrorLogin);
    controllerPassword.addListener(_resetErrorPassword);
    _ssAuthState = model.auth.stream.listen(_authStateListner);
    Future(() => _authStateListner(model.auth.state));
  }

  @override
  void dispose() {
    _ssAuthState.cancel();
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
