import '../interfaces/i_app_router.dart';
import '../interfaces/i_app_services.dart';
import '../interfaces/i_auth_service.dart';
import '../router/route_delegate.dart';
import '../router/route_registrator.dart';
import 'mock_auth_service.dart';

class MockAppServices implements IAppServices {
  MockAppServices(this.routeRegistrator);

  @override
  final AppRouteRegistrator routeRegistrator;

  @override
  late final IAppRouter router = AppRouteDelegate(routeRegistrator);

  @override
  final IAuthService auth = MockAuthService();

  @override
  void dispose() {
    auth.dispose();
    router.dispose();
  }
}
