import 'package:flutter/material.dart';

mixin WmTheme<T extends StatefulWidget> on State<T> {
  late ThemeData theme;

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }
}
