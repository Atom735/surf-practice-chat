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
    if (router.getHistory(-1) is SignInRouteInfo) {
      router.goBack();
    } else {
      router.setNewRoutePath(const SignInRouteInfo());
    }
  }

  late StreamSubscription _ssAuthState;
  Completer? _pendingAuth;
  void _authStateListner(AuthState state) {
    if (state is AuthStatePending || state is AuthStateInitializing) {
      final completer = _pendingAuth;
      if (completer != null && !completer.isCompleted) {
        completer.complete();
      }
      _pendingAuth = Completer.sync();
      router.pending(_pendingAuth!.future);
      return;
    }
    final completer = _pendingAuth;
    if (completer != null && !completer.isCompleted) {
      completer.complete();
      _pendingAuth = null;
    }
    if (state is AuthStateAuthorized) {
      router.setPages([const HomeRouteInfo()]);
    }
    if (state is AuthStateRegistered) {
      if (router.getHistory(-1) is SignInRouteInfo) {
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
    _ssAuthState.cancel();
  }
}