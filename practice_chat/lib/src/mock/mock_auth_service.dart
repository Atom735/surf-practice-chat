import '../interfaces/i_auth_service.dart';

class MockAuthService implements IAuthService {
  final Map<String, String> _registred = const {
    'free': 'free',
    'test': '123',
    'test@gmail.com': '12345',
  };
  final Map<String, String> _registredKeys = {};

  @override
  Future<String> signIn(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    username = username.trim();
    final pass = _registred[username];
    if (pass == null) {
      throw AuthErrorUnregisteredUser(username);
    }
    if (password != pass) {
      throw AuthErrorIncorrectPassword();
    }
    final key = 'key:$username+$password';
    _registredKeys[username] = key;
    return key;
  }

  @override
  Future<String> signUp(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    username = username.trim();
    if (_registred[username] != null) {
      throw AuthErrorRegistredUsername(username);
    }
    if (username.contains('error')) {
      throw AuthErrorInvalideteUsername(username);
    }
    if (password.contains('error')) {
      throw AuthErrorIncorrectPassword();
    }
    _registred[username] = password;
    return username;
  }

  @override
  void signOut() {}
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
