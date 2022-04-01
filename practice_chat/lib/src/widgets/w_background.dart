import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget result;
    if (theme.colorScheme.brightness == Brightness.dark) {
      result = Image.asset(
        'assets/images/background.dark.png',
        fit: BoxFit.cover,
      );
    } else {
      result = Image.asset(
        'assets/images/background.png',
        fit: BoxFit.cover,
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        print('BG: $constraints');
        return result;
      },
    );
  }
}
