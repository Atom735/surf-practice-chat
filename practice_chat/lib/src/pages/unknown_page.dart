import 'package:flutter/material.dart';

import '../common/route_info.dart';

class UnknownPage extends MaterialPage {
  UnknownPage(RouteInfo routeInfo)
      : super(
          child: UnknownScreenWidget(routeInfo),
          name: routeInfo.path,
          restorationId: routeInfo.path,
        );
}

class UnknownScreenWidget extends StatelessWidget {
  const UnknownScreenWidget(this.routeInfo, {Key? key}) : super(key: key);

  final RouteInfo routeInfo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.errorContainer.withOpacity(0.7),
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(routeInfo.path),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: FittedBox(
            child: Text(
              'Неизвестная странница...',
              style: theme.typography.englishLike.displayLarge!
                  .copyWith(color: theme.colorScheme.onErrorContainer),
            ),
          ),
        ),
      ),
    );
  }
}
