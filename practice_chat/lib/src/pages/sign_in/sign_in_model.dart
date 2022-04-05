import 'dart:async';

import 'package:elementary/elementary.dart';

import '../../router/route_interface.dart';
import '../../services/auth/auth_interface.dart';
import '../../services/auth/auth_states.dart';
import '../home/home_route_info.dart';
import '../sign_up/sign_up_route_info.dart';
import 'sign_in_route_info.dart';

class SignInModel extends ElementaryModel {
  SignInModel({required this.auth, required this.router});

  final IAppRouter router;
  final IAuthService auth;

  Future<void> signIn(String username, String password) async {
    try {
      auth.signIn(username, password);
    } on Object catch (e) {
      handleError(e);
    }
  }

  /// when 'create account' button pressed
  void handleSignUp() {
    if (router.getHistory(1) is SignUpRouteInfo) {
      router.goNext();
    } else {
      router.setNewRoutePath(const SignUpRouteInfo());
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
