import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theme_color_schemes.dart';
import 'theme_page_transition.dart';

final _themeDataLight = ThemeData.from(colorScheme: themeColorSchemeLight);
final themeDataLight = _themeDataLight.copyWith(
  appBarTheme: _themeDataLight.appBarTheme.copyWith(
    shadowColor: Colors.transparent,
    color: Colors.transparent,
    foregroundColor: _themeDataLight.colorScheme.onBackground,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  pageTransitionsTheme: themePageTransition,
  scaffoldBackgroundColor: Colors.transparent,
);

final _themeDataDark = ThemeData.from(colorScheme: themeColorSchemeDark);
final themeDataDark = _themeDataDark.copyWith(
  appBarTheme: _themeDataLight.appBarTheme.copyWith(
    shadowColor: Colors.transparent,
    color: Colors.transparent,
    foregroundColor: _themeDataDark.colorScheme.onBackground,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  pageTransitionsTheme: themePageTransition,
  scaffoldBackgroundColor: Colors.transparent,
);
