import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/captcha/captcha_dialog/captcha_dialog_page.dart';
import 'src/captcha/captcha_dialog/captcha_dialog_route_info.dart';
import 'src/captcha2/captcha2_service_mock.dart';
import 'src/captcha2/page/captcha2_dialog_page.dart';
import 'src/captcha2/page/captcha2_dialog_route_info.dart';
import 'src/pages/home/home_page.dart';
import 'src/pages/home/home_route_info.dart';
import 'src/pages/sign_in/sign_in_page.dart';
import 'src/pages/sign_in/sign_in_route_info.dart';
import 'src/pages/sign_up/sign_up_page.dart';
import 'src/pages/sign_up/sign_up_route_info.dart';
import 'src/pages/unknown_page.dart';
import 'src/router/route_delegate.dart';
import 'src/router/route_info.dart';
import 'src/router/route_registrator.dart';
import 'src/services/auth/auth_service_mocked.dart';
import 'src/widgets/w_app.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  final appRouteRegistart = AppRouteRegistrator(
    const CaptchaDialogRouteInfo(),
  )
    ..register(
      builder: Captcha2DialogPage.new,
      pattern: '',
      parser: (info) => throw UnsupportedError('non restorable (Captcha2)'),
    )
    ..register(
      builder: CaptchaDialogPage.new,
      pattern: '',
      parser: (info) => const CaptchaDialogRouteInfo(),
    )
    ..register(
      builder: SignInPage.new,
      pattern: const SignInRouteInfo().path,
      parser: (info) => const SignInRouteInfo(),
    )
    ..register(
      builder: SignUpPage.new,
      pattern: const SignUpRouteInfo().path,
      parser: (info) => const SignUpRouteInfo(),
    )
    ..register(
      builder: HomePage.new,
      pattern: RegExp(r'\/(?:home)?'),
      parser: (info) => const HomeRouteInfo(),
    )
    ..register(
      builder: UnknownPage.new,
      pattern: '',
      parser: (info) => const UnknownRouteInfo(''),
    );
  final appRouter = AppRouteDelegate(appRouteRegistart);
  final authService = AuthServiceMocked();
  final captchaService = Captcha2ServiceMock(appRouter);
  runApp(
    MultiProvider(
      providers: [
        appRouteRegistart.provider,
        appRouter.provider,
        authService.provider,
        captchaService.provider,
      ],
      child: const AppWidget(),
    ),
  );
}
