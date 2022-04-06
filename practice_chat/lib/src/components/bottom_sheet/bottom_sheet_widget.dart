import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet_wm_factory.dart';
import 'bottom_sheet_wm_interface.dart';

class BottomSheetWidget extends ElementaryWidget<IBottomSheetWidgetModel> {
  const BottomSheetWidget({
    Key? key,
    this.child,
    WidgetModelFactory wmFactory = homeWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final Widget? child;

  @override
  Widget build(IBottomSheetWidgetModel wm) => DecoratedBox(
      decoration: BoxDecoration(
        color: wm.theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(32),
        ),
        boxShadow: kElevationToShadow[6],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: wm.theme.colorScheme.surfaceVariant,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                    bottom: Radius.circular(4),
                  ),
                ),
                child: const SizedBox(
                  height: 8,
                  width: 64,
                ),
              ),
            ),
          ),
          Expanded(
            child: child ?? const SizedBox(),
          ),
        ],
      ));
}
