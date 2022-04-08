import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../captcha2_states.dart';
import 'captcha2_dialog_wm_interface.dart';

class Captcha2DialogWidget
    extends ElementaryWidget<ICaptcha2DialogWidgetModel> {
  const Captcha2DialogWidget({
    required WidgetModelFactory wmFactory,
    Key? key,
  }) : super(wmFactory, key: key);

  static final clicked = ValueNotifier<bool>(false);
  @override
  Widget build(ICaptcha2DialogWidgetModel wm) => Dialog(
        backgroundColor: wm.theme.colorScheme.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Captcha',
                textAlign: TextAlign.center,
                style: wm.theme.typography.englishLike.displaySmall!.copyWith(
                  color: wm.theme.colorScheme.primary,
                ),
              ),
              StreamBuilder<Captcha2State>(
                  stream: wm.stream,
                  initialData: wm.state,
                  builder: (context, snapshot) {
                    final sn = snapshot.data!;
                    final List<int> selected;
                    if (sn is Captcha2StateIdle) {
                      selected = sn.solved;
                    } else if (sn is Captcha2StatePending) {
                      selected = sn.solved;
                    } else {
                      selected = [];
                    }
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        wm.data.length,
                        (index) {
                          final d = wm.data[index] as int;
                          return Expanded(
                            child: GestureDetector(
                              onTap: wm.getHandleForIndex(index),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    boxShadow: selected.contains(index)
                                        ? kElevationToShadow[3]!
                                            .map((e) => BoxShadow(
                                                  color: wm.theme.colorScheme
                                                      .tertiary,
                                                  offset: e.offset,
                                                  blurRadius: e.blurRadius,
                                                  spreadRadius: e.spreadRadius,
                                                  blurStyle: e.blurStyle,
                                                ))
                                            .toList()
                                        : const []),
                                margin: const EdgeInsets.all(4),
                                child: Stack(
                                  children: [
                                    Image.asset(
                                        'assets/images/traffic-lights-disabled.png'),
                                    if (d != 0)
                                      ClipPath(
                                        clipper: _CustomTraficLightClipper(d),
                                        child: Image.asset(
                                            'assets/images/traffic-lights-enabled.png'),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
              Text(wm.desc),
              if (kDebugMode) Text(wm.data.toString()),
              ValueListenableBuilder<bool>(
                valueListenable: clicked,
                builder: (context, value, child) {
                  if (value) {
                    return const Center(
                      child: Icon(Icons.done),
                    );
                  }
                  return const SizedBox();
                },
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Send'),
              )
            ],
          ),
        ),
      );
}

class _CustomTraficLightClipper extends CustomClipper<Path> {
  _CustomTraficLightClipper(this.data);
  final int data;

  static const k1 = 0.37;
  static const k2 = 0.62;

  @override
  Path getClip(Size size) {
    final p = Path();

    if (data & (1 << 0) != 0) {
      p.addRect(
        Rect.fromLTRB(0, size.height * k2, size.width, size.height),
      );
    }
    if (data & (1 << 1) != 0) {
      p.addRect(
        Rect.fromLTRB(0, size.height * k1, size.width, size.height * k2),
      );
    }
    if (data & (1 << 2) != 0) {
      p.addRect(
        Rect.fromLTRB(0, 0, size.width, size.height * k1),
      );
    }
    return p;
  }

  @override
  bool shouldReclip(covariant _CustomTraficLightClipper oldClipper) =>
      oldClipper.data != data;
}
