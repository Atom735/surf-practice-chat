import 'package:flutter/material.dart';

const themePageTransition = PageTransitionsTheme(builders: {
  /// Android: <https://www.android.com/>
  TargetPlatform.android: AppPageTransitionBuilder(),

  /// Fuchsia: <https://fuchsia.dev/fuchsia-src/concepts>
  TargetPlatform.fuchsia: AppPageTransitionBuilder(),

  /// iOS: <https://www.apple.com/ios/>
  TargetPlatform.iOS: AppPageTransitionBuilder(),

  /// Linux: <https://www.linux.org>
  TargetPlatform.linux: AppPageTransitionBuilder(),

  /// macOS: <https://www.apple.com/macos>
  TargetPlatform.macOS: AppPageTransitionBuilder(),

  /// Windows: <https://www.windows.com>
  TargetPlatform.windows: AppPageTransitionBuilder(),
});

class AppPageTransitionBuilder extends PageTransitionsBuilder {
  const AppPageTransitionBuilder();
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    final textDirection = Directionality.of(context);
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: const Offset(0, 0.5))
          .animate(secondaryAnimation),
      textDirection: textDirection,
      transformHitTests: false,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0.5, 0), end: Offset.zero)
            .animate(animation),
        textDirection: textDirection,
        child: FadeTransition(
          opacity: Tween<double>(begin: 1, end: 0).animate(secondaryAnimation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      ),
    );
  }
}
