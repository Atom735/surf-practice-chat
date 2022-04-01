import 'package:flutter/foundation.dart';

class AppState {
  AppState({bool? themeMode}) : themeMode = ValueNotifier(themeMode);

  final ValueNotifier<bool?> themeMode;

  void dispose() {
    themeMode.dispose();
  }
}
