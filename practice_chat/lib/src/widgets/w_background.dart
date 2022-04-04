import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget result;
    if (theme.brightness == Brightness.dark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

      result = Image.asset(
        'assets/images/background.dark2.png',
        fit: BoxFit.cover,
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

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
