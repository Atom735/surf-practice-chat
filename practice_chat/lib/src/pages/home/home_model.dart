import 'package:elementary/elementary.dart';

import '../../interfaces/i_app_router.dart';
import '../../interfaces/i_auth_service.dart';

class HomeModel extends ElementaryModel {
  HomeModel({required this.auth, required this.router});

  final IAppRouter router;
  final IAuthService auth;

  Future<void> signIn(String username, String password) async {
    try {
      await router.pending(auth.signIn(username, password));
    } on Object catch (e) {
      handleError(e);
    }
  }
}
