import 'package:flutter/widgets.dart';

import '../../interfaces/i_app_services.dart';
import 'sign_in_model.dart';
import 'sign_in_wm.dart';

/// Factory for [SignInWidgetModel].
SignInWidgetModel signInWidgetModelFactory(
  BuildContext context,
) {
  final services = context.services;
  final model = SignInModel(
    auth: services.auth,
    router: services.router,
  );
  return SignInWidgetModel(
    model: model,
  );
}
