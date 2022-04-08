import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../captcha2_states.dart';
import 'captcha2_dialog_model.dart';
import 'captcha2_dialog_widget.dart';
import 'captcha2_dialog_wm_interface.dart';

/// Widget Model for [Captcha2DialogWidget].
class Captcha2DialogWidgetModel
    extends WidgetModel<Captcha2DialogWidget, Captcha2DialogModel>
    implements ICaptcha2DialogWidgetModel {
  Captcha2DialogWidgetModel({
    required Captcha2DialogModel model,
  }) : super(model);

  @override
  late ThemeData theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
  }

  @override
  String get desc => model.task.desc;

  @override
  List get data => model.task.data;

  @override
  void Function() getHandleForIndex(int index) =>
      () => model.cubit.switchSelected(index);

  @override
  Captcha2State get state => model.cubit.state;

  @override
  Stream<Captcha2State> get stream => model.cubit.stream;
}
