import '../mock/mock_auth_service.dart';

abstract class IAuthService {
  /// for implement only
  // ignore: unused_element
  IAuthService._();

  // ignore: sort_unnamed_constructors_first
  factory IAuthService() => _instance;
  static final _instance = MockAuthService();

  /// returns key
  Future<String> signIn(String username, String password);

  /// returs username
  Future<String> signUp(String username, String password);

  void signOut();
}
