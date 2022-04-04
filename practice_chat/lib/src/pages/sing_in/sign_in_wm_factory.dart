import 'package:flutter/widgets.dart';

import 'sign_in_model.dart';
import 'sign_in_wm.dart';

/// Factory for [SignInWidgetModel].
SignInWidgetModel signInWidgetModelFactory(
  BuildContext context,
) {
  final model = SignInModel();
  return SignInWidgetModel(
    model: model,
  );
}
