import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    required this.backgroundColor,
    required this.pinColor,
    this.shadows,
    this.fadeEnabled,
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;
  final Color backgroundColor;
  final Color pinColor;
  final List<BoxShadow>? shadows;
  final ValueNotifier<bool>? fadeEnabled;

  @override
  Widget build(BuildContext context) {
    var child = this.child;
    if (child != null && fadeEnabled != null) {
      child = Stack(
        fit: StackFit.expand,
        children: [
          child,
          _OverlapFadeWidget(
            color: backgroundColor,
            enabled: fadeEnabled!,
          ),
        ],
      );
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(32),
        ),
        boxShadow: shadows,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: pinColor,
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
      ),
    );
  }
}

class _OverlapFadeWidget extends StatelessWidget {
  const _OverlapFadeWidget({
    required this.color,
    required this.enabled,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<bool> enabled;
  final Color color;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: enabled,
        builder: (context, enabled, child) =>
            Offstage(offstage: !enabled, child: child),
        child: Align(
          alignment: Alignment.topCenter,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  color,
                  color.withOpacity(0),
                ],
              ),
            ),
            child: const SizedBox(
              height: 64,
              width: double.infinity,
            ),
          ),
        ),
      );
}
