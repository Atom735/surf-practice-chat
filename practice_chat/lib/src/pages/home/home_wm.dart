import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'home_model.dart';
import 'home_screen.dart';
import 'home_wm_interface.dart';

/// Widget Model for [HomeScreen].
class HomeWidgetModel extends WidgetModel<HomeScreen, HomeModel>
    implements IHomeWidgetModel {
  HomeWidgetModel({
    required HomeModel model,
  }) : super(model);

  @override
  late ThemeData theme;

  @override
  final scrollOverlaped = ValueNotifier<bool>(false);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
  }

  @override
  void dispose() {
    scrollOverlaped.dispose();
    super.dispose();
  }
}
