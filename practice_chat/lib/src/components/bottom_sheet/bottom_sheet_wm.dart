import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet_model.dart';
import 'bottom_sheet_widget.dart';
import 'bottom_sheet_wm_interface.dart';

/// Widget Model for [BottomSheetWidget].
class BottomSheetWidgetModel
    extends WidgetModel<BottomSheetWidget, BottomSheetModel>
    implements IBottomSheetWidgetModel {
  BottomSheetWidgetModel({
    required BottomSheetModel model,
  }) : super(model);

  @override
  late ThemeData theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
  }
}
