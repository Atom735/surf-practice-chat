import 'dart:math';

import 'package:flutter/material.dart';

import '../captcha2/captcha2_service_interface.dart';
import '../captcha2/captcha2_task_data.dart';

class DebuggerWidget extends StatelessWidget {
  const DebuggerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton.small(
          onPressed: () async {
            final rand = Random(DateTime.now().millisecondsSinceEpoch);
            final data =
                List.generate(rand.nextInt(5) + 3, (i) => rand.nextInt(1 << 3));
            await ICaptcha2Service.of(context).openCaptchaDialog(
              Captcha2TaskData(
                  data, 'Выберете светофоры где горит зеленый сигнал'),
            );
          },
        ),
      );
}
