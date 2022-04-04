import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../router/route_registrator.dart';
import 'i_app_router.dart';
import 'i_auth_service.dart';

abstract class IAppServices {
  /// for implement only
  IAppServices._();

  void dispose();

  AppRouteRegistrator get routeRegistrator;

  IAppRouter get router;

  IAuthService get auth;
}

extension IAppServiceX on BuildContext {
  IAppServices get services => read<IAppServices>();
}

typedef IAppServicesFactory = IAppServices Function(BuildContext context);
