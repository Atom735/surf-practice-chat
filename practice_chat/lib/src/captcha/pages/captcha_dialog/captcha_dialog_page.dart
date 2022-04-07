import 'package:flutter/material.dart';

import 'captcha_dialog_route_info.dart';
import 'captcha_dialog_widget.dart';

class CaptchaDialogPage extends MaterialPage {
  CaptchaDialogPage(this.routeInfo)
      : super(
          child: const CaptchaDialogScreen(),
          name: routeInfo.path,
          restorationId: routeInfo.path,
        );

  final CaptchaDialogRouteInfo routeInfo;

  @override
  bool canUpdate(Page other) {
    assert(() {
      print('$this try to update by $other');
      return true;
    }(), 'debug printing');
    return super.canUpdate(other);
  }
}
