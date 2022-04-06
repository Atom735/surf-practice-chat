import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Interface of [IBottomSheetWidgetModel].
abstract class IBottomSheetWidgetModel extends IWidgetModel {
  /// For implements only
  IBottomSheetWidgetModel._();

  ThemeData get theme;
}
