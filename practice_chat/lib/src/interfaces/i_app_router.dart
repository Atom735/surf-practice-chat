import 'package:flutter/cupertino.dart';

abstract class IAppRouter {
  /// For implement only
  const IAppRouter._();

  void goBack();

  void goToHome();

  void goToSignIn();

  void goToSignUp();

  void dispose();
}

class AppRouterProvider extends InheritedWidget {
  const AppRouterProvider(
    this.router, {
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  final IAppRouter router;

  @override
  bool updateShouldNotify(covariant AppRouterProvider oldWidget) =>
      oldWidget.router != router;
}
