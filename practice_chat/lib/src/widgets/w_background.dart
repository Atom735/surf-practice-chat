import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.colorScheme.brightness == Brightness.dark) {
      return Image.asset(
        'assets/images/background.dark.png',
        fit: BoxFit.cover,
      );
    }
    return Image.asset(
      'assets/images/background.png',
      fit: BoxFit.cover,
    );
  }
}
