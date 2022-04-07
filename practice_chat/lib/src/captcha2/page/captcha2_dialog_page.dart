import 'package:flutter/material.dart';

import '../../router/route_interface.dart';
import 'captcha2_dialog_model.dart';
import 'captcha2_dialog_route_info.dart';
import 'captcha2_dialog_widget.dart';
import 'captcha2_dialog_wm.dart';

class Captcha2DialogPage<T> extends Page<void> {
  Captcha2DialogPage(this.routeInfo)
      : super(
            name: routeInfo.path,

            /// non restorable
            restorationId: null);

  final Captcha2DialogRouteInfo<T> routeInfo;

  @override
  Route<void> createRoute(BuildContext context) =>
      Captcha2DialogPageRoute<T>(this);

  @override
  bool canUpdate(Page other) {
    assert(() {
      print('$this try to update by $other');
      return true;
    }(), 'debug printing');
    return super.canUpdate(other);
  }
}

class Captcha2DialogPageRoute<T> extends PageRoute<void>
    with MaterialRouteTransitionMixin<void> {
  Captcha2DialogPageRoute(
    Captcha2DialogPage page,
  ) : super(settings: page);

  Captcha2DialogPage<T> get _page => settings as Captcha2DialogPage<T>;

  /// Factory for [Captcha2DialogWidgetModel].
  Captcha2DialogWidgetModel wmFactory(BuildContext context) {
    final model = Captcha2DialogModel(
      router: IAppRouter.of(context),
      completer: _page.routeInfo.completer,
      task: _page.routeInfo.data,
    );
    return Captcha2DialogWidgetModel(
      model: model,
      theme: Theme.of(context),
    );
  }

  @override
  Widget buildContent(BuildContext context) => Captcha2DialogWidget(
        wmFactory: wmFactory,
      );

  @override
  bool get opaque => false;

  @override
  bool get maintainState => false;

  @override
  bool get fullscreenDialog => false;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';
}
