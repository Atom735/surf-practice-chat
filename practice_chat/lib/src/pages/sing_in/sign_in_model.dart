import 'dart:async';

import 'package:elementary/elementary.dart';

import '../../router/route_interface.dart';
import '../../services/auth/auth_interface.dart';
import '../../services/auth/auth_states.dart';
import '../home/home_route_info.dart';

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
  void handleSignUp() {}

  late StreamSubscription _ssAuthState;
  void _authStateListner(AuthState state) {
    if (state is AuthStateAuthorized) {
      router.setPages([const HomeRouteInfo()]);
    }
  }

  @override
  void init() {
    _ssAuthState = auth.stream.listen(_authStateListner);
  }

  @override
  void dispose() {
    _ssAuthState.cancel();
  }
}
