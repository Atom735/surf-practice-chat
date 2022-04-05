import 'package:flutter/material.dart';

import 'src/mock/mock_app_services.dart';
import 'src/pages/home/home_page.dart';
import 'src/pages/home/home_route_info.dart';
import 'src/pages/sing_in/sign_in_page.dart';
import 'src/pages/sing_in/sign_in_route_info.dart';
import 'src/router/route_registrator.dart';
import 'src/widgets/w_app.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(
    AppWidget(
      (context) => MockAppServices(
        AppRouteRegistrator(
          const SignInRouteInfo(),
        )
          ..register(
            builder: SignInPage.new,
            pattern: '/login',
            parser: (info) => const SignInRouteInfo(),
          )
          ..register(
            builder: HomePage.new,
            pattern: RegExp(r'\/(?:home)?'),
            parser: (info) => const HomeRouteInfo(),
          ),
      ),
    ),
  );
}
