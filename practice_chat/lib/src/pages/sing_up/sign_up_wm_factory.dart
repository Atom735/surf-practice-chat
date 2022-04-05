import 'package:flutter/widgets.dart';

import '../../interfaces/i_app_services.dart';
import 'sign_up_model.dart';
import 'sign_up_wm.dart';

/// Factory for [SignUpWidgetModel].
SignUpWidgetModel signUpWidgetModelFactory(
  BuildContext context,
) {
  final services = context.services;
  final model = SignUpModel(
    auth: services.auth,
    router: services.router,
  );
  return SignUpWidgetModel(
    model: model,
  );
}
