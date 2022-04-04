import 'package:elementary/elementary.dart';

import 'sign_in_model.dart';
import 'sign_in_screen.dart';
import 'sign_in_wm_interface.dart';

/// Widget Model for [SignInScreen].
class SignInWidgetModel extends WidgetModel<SignInScreen, SignInModel>
    implements ISignInWidgetModel {
  SignInWidgetModel({
    required SignInModel model,
  }) : super(model);
}
