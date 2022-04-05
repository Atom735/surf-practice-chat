import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';
import 'home_wm_factory.dart';
import 'home_wm_interface.dart';

class HomeScreen extends ElementaryWidget<IHomeWidgetModel> {
  const HomeScreen({
    Key? key,
    WidgetModelFactory wmFactory = homeWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IHomeWidgetModel wm) => const HomeScreenWidget();
}
