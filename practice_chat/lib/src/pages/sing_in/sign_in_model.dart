import 'package:elementary/elementary.dart';

import '../../interfaces/i_app_router.dart';
import '../../interfaces/i_auth_service.dart';
import '../../services/auth/auth_interface.dart';
import '../home/home_route_info.dart';

class SignInModel extends ElementaryModel {
  SignInModel({required this.auth, required this.router});

  final IAppRouter router;
  final IAuthService auth;

  Future<void> signIn(String username, String password) async {
    try {
      await router.pending(auth.signIn(username, password));
      router.setNewRoutePath(const HomeRouteInfo()).ignore();
    } on Object catch (e) {
      handleError(e);
    }
  }
}
