import 'dart:math';

import 'package:bloc/bloc.dart';

import 'auth_errors.dart';
import 'auth_service_base.dart';
import 'auth_states.dart';

class AuthServiceMocked extends Cubit<AuthState> with AuthServiceBase {
  AuthServiceMocked() : super(const AuthStateInitializing());

  final Map<String, String> _registred = {
    'free': 'free',
    'test': '123',
    'test@gmail.com': '12345',
    '': '',
  };
  final Map<String, String> _registredKeys = {};

  @override
  Future<void> signIn(String username, String password) async {
    username = username.trim();
    emit(const AuthStatePending());
    await Future.delayed(const Duration(seconds: 1));
    final pass = _registred[username];
    if (pass == null) {
      return emit(AuthStateError(
        username: username,
        error: AuthErrorUnregisteredUser(username),
      ));
    }
    if (password != pass) {
      return emit(AuthStateError(
        username: username,
        error: const AuthErrorIncorrectPassword(),
      ));
    }
    if (Random().nextInt(256) < 40) {
      return emit(AuthStateError(
        username: username,
        error: Exception('ну тут кароч текст произвольной ошибки...'),
      ));
    }
    final key = 'key:$username+$password';
    _registredKeys[username] = key;
    return emit(AuthStateAuthorized(
      username: username,
      token: key,
      expires: DateTime.now().add(const Duration(days: 1)),
    ));
  }

  @override
  Future<void> signUp(String username, String password) async {
    username = username.trim();
    emit(const AuthStatePending());
    await Future.delayed(const Duration(seconds: 1));
    username = username.trim();
    if (_registred[username] != null) {
      return emit(AuthStateError(
        username: username,
        error: AuthErrorRegistredUsername(username),
      ));
    }
    if (username.contains('error')) {
      return emit(AuthStateError(
        username: username,
        error: AuthErrorUnregisteredUser(username),
      ));
    }
    if (password.contains('error')) {
      return emit(AuthStateError(
        username: username,
        error: const AuthErrorIncorrectPassword(),
      ));
    }
    _registred[username] = password;
    emit(AuthStateRegistered(username));
    emit(AuthStateUnauthorized(username: username));
  }

  @override
  Future<void> signOut() async {
    emit(const AuthStatePending());
    await Future.delayed(const Duration(microseconds: 444));
    return emit(const AuthStateUnauthorized());
  }

  @override
  Future<void> init() async {
    await Future.delayed(const Duration(milliseconds: 333));

    if (Random().nextInt(256) < 40) {
      emit(AuthStateAuthorized(
        username: 'free',
        token: 'key:free+free',
        expires: DateTime(2023),
      ));
    } else {
      emit(const AuthStateUnauthorized());
    }
  }

  @override
  Future<void> dispose() async {
    await close();
  }

  @override
  void resetError() {
    if (state is AuthStateError) {
      emit(const AuthStateUnauthorized());
    }
  }
}
