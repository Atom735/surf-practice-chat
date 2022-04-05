import 'package:flutter/widgets.dart';

import '../../router/route_interface.dart';
import '../../services/auth/auth_interface.dart';
import 'sign_up_model.dart';
import 'sign_up_wm.dart';

/// Factory for [SignUpWidgetModel].
SignUpWidgetModel signInWidgetModelFactory(
  BuildContext context,
) {
  final model = SignUpModel(
    auth: IAuthService.of(context),
    router: IAppRouter.of(context),
  );
  return SignUpWidgetModel(
    model: model,
  );
}
