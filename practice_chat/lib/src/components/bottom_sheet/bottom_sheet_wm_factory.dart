import 'package:flutter/widgets.dart';

import 'bottom_sheet_model.dart';
import 'bottom_sheet_wm.dart';

/// Factory for [BottomSheetWidgetModel].
BottomSheetWidgetModel homeWidgetModelFactory(
  BuildContext context,
) {
  final model = BottomSheetModel();
  return BottomSheetWidgetModel(
    model: model,
  );
}
