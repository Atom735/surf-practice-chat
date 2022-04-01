import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theme_color_schemes.dart';

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
  scaffoldBackgroundColor: Colors.white70,
);

final _themeDataDark = ThemeData.from(colorScheme: themeColorSchemeDark);
final themeDataDark = _themeDataDark.copyWith(
  appBarTheme: _themeDataLight.appBarTheme.copyWith(),
);
