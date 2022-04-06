import 'package:flutter/material.dart';

import '../components/bottom_sheet_widget.dart';
import '../home_screen.dart';
import '../utils/scroll_physics/custom_clamping.dart';

class AppBarFlexRenderer2 extends StatelessWidget {
  const AppBarFlexRenderer2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          assert(
            context.dependOnInheritedWidgetOfExactType<
                    FlexibleSpaceBarSettings>() !=
                null,
            '''A FlexibleSpaceBar must be wrapped in the widget returned by FlexibleSpaceBar.createSettings().''',
          );
          final settings = context
              .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;

          final deltaExtent = settings.maxExtent - settings.minExtent;

          // 0.0 -> Expanded
          // 1.0 -> Collapsed to toolbar
          final t = (1.0 -
                  (settings.currentExtent - settings.minExtent) / deltaExtent)
              .clamp(0.0, 1.0);

          return SizedBox(
            height: constraints.maxHeight,
            child: Opacity(
              opacity: 1.0 - t,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: settings.currentExtent - settings.minExtent,
                  child: const StoriesTileWidget(),
                ),
              ),
            ),
          );
        },
      );
}

class CustomScrollController extends ScrollController {
  CustomScrollController() {
    addListener(posListner);
  }
  final sp = <ScrollPosition>[];

  void posListner() {
    print(this);
    for (var i = 0; i < sp.length; i++) {
      print('$i: ${sp[i]}');
    }
  }

  @override
  void attach(ScrollPosition position) {
    sp.add(position);
    position.addListener(posListner);
    super.attach(position);
  }

  /// Unregister the given position with this controller.
  ///
  /// After this function returns, the [animateTo] and [jumpTo] methods on this
  /// controller will not manipulate the given position.
  @override
  void detach(ScrollPosition position) {
    sp.remove(position);
    position.removeListener(posListner);
    super.detach(position);
  }
}
