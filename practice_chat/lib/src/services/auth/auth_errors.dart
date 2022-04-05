import 'package:meta/meta.dart';

@immutable
abstract class AuthError {
  const AuthError();
  String get message;
  @override
  String toString() => 'AuthError: $message';
}

class AuthErrorUnregisteredUser extends AuthError {
  const AuthErrorUnregisteredUser(this.username);

  final String username;

  @override
  String get message => 'Unregisterd username "$username"';
}

class AuthErrorIncorrectPassword extends AuthError {
  const AuthErrorIncorrectPassword();

  @override
  String get message => 'Incorrect password';
}

class AuthErrorRegistredUsername extends AuthError {
  const AuthErrorRegistredUsername(this.username);

  final String username;

  @override
  String get message => 'Username "$username" is not available';
}

class AuthErrorIncorrectUsername extends AuthError {
  const AuthErrorIncorrectUsername();

  @override
  String get message => 'Incorrect username';
}
