import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:elementary/elementary.dart';

import '../../router/route_interface.dart';
import '../captcha2_service_interface.dart';
import '../captcha2_states.dart';
import '../captcha2_task_data.dart';

class Captcha2DialogModel<T> extends ElementaryModel {
  Captcha2DialogModel({
    required this.router,
    required this.completer,
    required this.task,
    required ICaptcha2Service captchaService,
  }) : cubit = Captcha2DialogModelCubit(captchaService);

  final IAppRouter router;
  final Completer<void> completer;
  final Captcha2TaskData<T> task;
  final Captcha2DialogModelCubit cubit;
}

class Captcha2DialogModelCubit extends Cubit<Captcha2State> {
  Captcha2DialogModelCubit(this.service) : super(const Captcha2StateIdle());

  final ICaptcha2Service service;
  void switchSelected(int index) {
    final s = state as Captcha2StateIdle;
    final n = s.solved.toList();
    if (!n.remove(index)) {
      n.add(index);
    }
    emit(Captcha2StateIdle(solved: n, error: s.error));
  }
}
