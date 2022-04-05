import 'package:flutter/widgets.dart';

import 'home_model.dart';
import 'home_wm.dart';

/// Factory for [HomeWidgetModel].
HomeWidgetModel homeWidgetModelFactory(
  BuildContext context,
) {
  final model = HomeModel();
  return HomeWidgetModel(
    model: model,
  );
}
