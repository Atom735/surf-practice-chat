import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

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
              SizedBox(
                child: Builder(
                  builder: (context) => GestureDetector(
                    onTapDown: (details) {
                      final rb =
                          context.findAncestorRenderObjectOfType<RenderBox>()!;

                      final sz = rb.size;
                      final lp = details.localPosition;
                      final rp = Offset(lp.dx / sz.width, lp.dy / sz.height);
                      clicked.value = rp.dx > 0.63 && rp.dx < 0.755;

                      print(sz);
                      print('x: ${rp.dx}\ny: ${rp.dy}');
                    },
                    child: Image.network(
                        'https://cdn.pixabay.com/photo/2017/03/15/23/10/traffic-lights-2147790_1280.png'),
                  ),
                ),
              ),
              const Text(
                'Нажмите на светофор где горят красный и зеленый сигнал',
              ),
              ValueListenableBuilder<bool>(
                valueListenable: clicked,
                builder: (context, value, child) {
                  if (value) {
                    return const Center(
                      child: const Icon(Icons.done),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      );
}
