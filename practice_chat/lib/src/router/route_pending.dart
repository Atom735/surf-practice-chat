import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AppRoutePendingPage extends Page<void> {
  @literal
  const AppRoutePendingPage() : super(key: const ObjectKey(#pending));

  @override
  Route<void> createRoute(BuildContext context) => DialogRoute(
        settings: this,
        barrierDismissible: false,
        barrierColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black.withOpacity(0.7)
            : Colors.white54,
        context: context,
        builder: (context) => const CircularProgressIndicator.adaptive(),
      );
}
