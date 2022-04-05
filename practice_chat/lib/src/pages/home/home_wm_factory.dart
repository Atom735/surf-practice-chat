import 'package:flutter/widgets.dart';

import '../../interfaces/i_app_services.dart';
import 'home_model.dart';
import 'home_wm.dart';

/// Factory for [HomeWidgetModel].
HomeWidgetModel homeWidgetModelFactory(
  BuildContext context,
) {
  final services = context.services;
  final model = HomeModel(
    auth: services.auth,
    router: services.router,
  );
  return HomeWidgetModel(
    model: model,
  );
}
