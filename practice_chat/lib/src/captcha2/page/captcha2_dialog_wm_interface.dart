import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../captcha2_states.dart';

/// Interface of [ICaptcha2DialogWidgetModel].
abstract class ICaptcha2DialogWidgetModel extends IWidgetModel {
  /// For implements only
  ICaptcha2DialogWidgetModel._();

  ThemeData get theme;

  String get desc;

  List get data;

  Captcha2State get state;
  Stream<Captcha2State> get stream;

  void Function() getHandleForIndex(int index);
}
