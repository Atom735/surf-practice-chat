import 'package:flutter/widgets.dart';

import '../../../router/route_interface.dart';
import 'captcha_dialog_model.dart';
import 'captcha_dialog_wm.dart';

/// Factory for [CaptchaDialogWidgetModel].
CaptchaDialogWidgetModel signInWidgetModelFactory(
  BuildContext context,
) {
  final model = CaptchaDialogModel(
    router: IAppRouter.of(context),
  );
  return CaptchaDialogWidgetModel(
    model: model,
  );
}
