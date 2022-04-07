import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Interface of [ICaptcha2DialogWidgetModel].
abstract class ICaptcha2DialogWidgetModel extends IWidgetModel {
  /// For implements only
  ICaptcha2DialogWidgetModel._();

  ThemeData get theme;
}
