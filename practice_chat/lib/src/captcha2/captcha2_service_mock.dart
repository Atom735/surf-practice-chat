import 'dart:async';

import '../router/route_interface.dart';
import 'captcha2_service_base.dart';
import 'captcha2_task_data.dart';
import 'page/captcha2_dialog_route_info.dart';

class Captcha2ServiceMock extends Captcha2ServiceBase {
  Captcha2ServiceMock(this.appRouter);

  final IAppRouter appRouter;

  @override
  void init() {
    // TODO: implement init
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<void> openCaptchaDialog<T>(Captcha2TaskData<T> data) {
    final completer = Completer<void>();
    appRouter.setNewRoutePath(Captcha2DialogRouteInfo(completer, data));
    return completer.future;
  }
}
