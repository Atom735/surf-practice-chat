import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Interface of [IHomeWidgetModel].
abstract class IHomeWidgetModel extends IWidgetModel {
  /// For implements only
  IHomeWidgetModel._();

  ThemeData get theme;
}
