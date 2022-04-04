import '../interfaces/i_app_router.dart';
import '../interfaces/i_app_services.dart';
import '../interfaces/i_auth_service.dart';
import '../router/route_delegate.dart';
import 'mock_auth_service.dart';

class MockAppServices implements IAppServices {
  @override
  final IAuthService auth = MockAuthService();

  @override
  final IAppRouter router = AppRouteDelegate();

  @override
  void dispose() {
    auth.dispose();
    router.dispose();
  }
}
