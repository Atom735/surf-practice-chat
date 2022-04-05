import '../i_service.dart';
import 'auth_states.dart';

abstract class IAuthService implements IServiceWithState<AuthState> {
  /// For implement only
  IAuthService._();

  void signIn(String username, String password);

  void signUp(String username, String password);

  void signOut();
}
