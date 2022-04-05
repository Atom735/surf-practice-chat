import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../i_service.dart';
import 'auth_states.dart';

abstract class IAuthService implements IServiceWithState<AuthState> {
  /// For implement only
  IAuthService._();

  static IAuthService of(BuildContext context) => context.read<IAuthService>();

  void signIn(String username, String password);
  void signUp(String username, String password);
  void signOut();

  void resetError();
}
