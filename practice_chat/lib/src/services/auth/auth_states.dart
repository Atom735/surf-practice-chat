import 'package:meta/meta.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateInitializing extends AuthState {
  @literal
  const AuthStateInitializing();

  @override
  String toString() => 'AuthStateInitializing()';
}

class AuthStateUnauthorized extends AuthState {
  const AuthStateUnauthorized({this.username = ''});

  final String username;

  @override
  String toString() => 'AuthStateUnauthorized(username: $username)';
}

class AuthStateAuthorized extends AuthState {
  const AuthStateAuthorized({
    required this.username,
    required this.token,
    required this.expires,
  });

  final String username;
  final String token;
  final DateTime expires;

  @override
  String toString() =>
      '''AuthStateAuthorized(username: $username, token: $token, expires: $expires)''';
}

class AuthStateError extends AuthState {
  const AuthStateError({
    required this.username,
    required this.error,
  });

  final String username;

  final Object error;

  @override
  String toString() => 'AuthStateError(username: $username, error: $error)';
}

class AuthStatePending extends AuthState {
  @literal
  const AuthStatePending();

  @override
  String toString() => 'AuthStatePending()';
}
