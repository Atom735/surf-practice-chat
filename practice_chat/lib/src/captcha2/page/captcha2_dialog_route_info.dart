import 'dart:async';

import 'package:meta/meta.dart';

import '../../router/route_info.dart';
import '../captcha2_task_data.dart';

@immutable
class Captcha2DialogRouteInfo<T> implements RouteInfo {
  @literal
  const Captcha2DialogRouteInfo(
    this.completer,
    this.data,
  );

  @override
  String get path => '/captcha2';

  final Completer<void> completer;

  final Captcha2TaskData<T> data;
}
