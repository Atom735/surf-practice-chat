import 'package:elementary/elementary.dart';

import '../../interfaces/i_app_router.dart';
import '../../interfaces/i_auth_service.dart';
import '../home/home_route_info.dart';

class SignUpModel extends ElementaryModel {
  SignUpModel({required this.auth, required this.router});

  final IAppRouter router;
  final IAuthService auth;

  Future<void> signUp(String username, String password) async {
    try {
      await router.pending(auth.signUp(username, password));
      router.setNewRoutePath(const HomeRouteInfo()).ignore();
    } on Object catch (e) {
      handleError(e);
    }
  }
}
