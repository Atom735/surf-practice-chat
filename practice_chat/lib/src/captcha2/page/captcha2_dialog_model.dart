import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:elementary/elementary.dart';

import '../../router/route_interface.dart';
import '../captcha2_states.dart';
import '../captcha2_task_data.dart';

class Captcha2DialogModel<T> extends ElementaryModel {
  Captcha2DialogModel({
    required this.router,
    required this.completer,
    required this.task,
  });

  final IAppRouter router;
  final Completer<void> completer;
  final Captcha2TaskData<T> task;
  final Captcha2DialogModelCubit cubit = Captcha2DialogModelCubit();
}

class Captcha2DialogModelCubit extends Cubit<Captcha2State> {
  Captcha2DialogModelCubit() : super(const Captcha2StateIdle());
}
