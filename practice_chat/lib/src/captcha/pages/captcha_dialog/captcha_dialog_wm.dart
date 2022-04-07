import 'package:elementary/elementary.dart';

import 'captcha_dialog_model.dart';
import 'captcha_dialog_widget.dart';
import 'captcha_dialog_wm_interface.dart';

/// Widget Model for [CaptchaDialogScreen].
class CaptchaDialogWidgetModel
    extends WidgetModel<CaptchaDialogScreen, CaptchaDialogModel>
    implements ICaptchaDialogWidgetModel {
  CaptchaDialogWidgetModel({
    required CaptchaDialogModel model,
  }) : super(model);
}
