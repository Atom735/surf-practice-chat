import 'package:flutter/widgets.dart';

import '../../router/route_interface.dart';
import '../../services/auth/auth_interface.dart';
import 'sign_in_model.dart';
import 'sign_in_wm.dart';

/// Factory for [SignInWidgetModel].
SignInWidgetModel signInWidgetModelFactory(
  BuildContext context,
) {
  final model = SignInModel(
    auth: IAuthService.of(context),
    router: IAppRouter.of(context),
  );
  return SignInWidgetModel(
    model: model,
  );
}
