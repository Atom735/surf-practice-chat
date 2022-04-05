import 'dart:async';

import 'package:elementary/elementary.dart';

import '../../router/route_interface.dart';
import '../../services/auth/auth_interface.dart';
import '../../services/auth/auth_states.dart';
import '../home/home_route_info.dart';
import '../sign_in/sign_in_route_info.dart';

class SignUpModel extends ElementaryModel {
  SignUpModel({required this.auth, required this.router});

  final IAppRouter router;
  final IAuthService auth;

  Future<void> signUp(String username, String password) async {
    try {
      auth.signUp(username, password);
    } on Object catch (e) {
      handleError(e);
    }
  }

  /// when 'create account' button pressed
  void handleSignIn() {
    auth.resetError();
    if (router.getHistory(1) is SignInRouteInfo) {
      router.goBack();
    } else {
      router.setNewRoutePath(const SignInRouteInfo());
    }
  }

  void Function()? _pending;
  late StreamSubscription _ssAuthState;
  void _authStateListner(AuthState state) {
    _pending?.call();
    _pending = null;
    if (state is AuthStateInitializing || state is AuthStatePending) {
      _pending = router.pending();
    }
    if (state is AuthStateAuthorized) {
      router.setPages([const HomeRouteInfo()]);
    } else if (state is AuthStateRegistered) {
      if (router.getHistory(1) is SignInRouteInfo) {
        router.goBack();
      } else {
        router.setNewRoutePath(const SignInRouteInfo());
      }
    }
  }

  @override
  void init() {
    _ssAuthState = auth.stream.listen(_authStateListner);
    Future(() => _authStateListner(auth.state));
  }

  @override
  void dispose() {
    _pending?.call();
    _pending = null;
    _ssAuthState.cancel();
  }
}
