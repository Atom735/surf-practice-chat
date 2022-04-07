import 'package:elementary/elementary.dart';
import 'package:flutter/src/material/theme_data.dart';

import 'captcha2_dialog_model.dart';
import 'captcha2_dialog_widget.dart';
import 'captcha2_dialog_wm_interface.dart';

/// Widget Model for [Captcha2DialogWidget].
class Captcha2DialogWidgetModel
    extends WidgetModel<Captcha2DialogWidget, Captcha2DialogModel>
    implements ICaptcha2DialogWidgetModel {
  Captcha2DialogWidgetModel({
    required Captcha2DialogModel model,
    required this.theme,
  }) : super(model);

  @override
  final ThemeData theme;
}
