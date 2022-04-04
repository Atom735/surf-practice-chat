abstract class IAuthService {
  /// for implement only
  IAuthService._();

  String? get token;

  /// returns key
  Future<String> signIn(String username, String password);

  /// returs username
  Future<String> signUp(String username, String password);

  void signOut();

  void dispose();
}

class AuthErrorUnregisteredUser implements Exception {
  AuthErrorUnregisteredUser(this.username);

  final String username;

  @override
  String toString() => 'AuthErrorUnregisteredUser(username: $username)';
}

class AuthErrorIncorrectPassword implements Exception {
  AuthErrorIncorrectPassword();

  @override
  String toString() => 'AuthErrorIncorrectPassword()';
}

class AuthErrorRegistredUsername implements Exception {
  AuthErrorRegistredUsername(this.username);

  final String username;

  @override
  String toString() => 'AuthErrorRegistredUsername(username: $username)';
}

class AuthErrorInvalideteUsername implements Exception {
  AuthErrorInvalideteUsername(this.username);

  final String username;

  @override
  String toString() => 'AuthErrorInvalideteUsername(username: $username)';
}
