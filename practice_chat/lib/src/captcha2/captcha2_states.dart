import 'package:meta/meta.dart';

@immutable
abstract class Captcha2State {
  const Captcha2State();
}

/// Ошибка решения капчи, либо первый запуск отображения капчи
class Captcha2StateIdle extends Captcha2State {
  const Captcha2StateIdle({this.solved = const [], this.error});

  /// Данные заполнения при открытии экрана
  final List<int> solved;

  /// Сообщение об ошибке
  final String? error;
}

/// Отправка решения капчи на проверку
class Captcha2StatePending extends Captcha2State {
  const Captcha2StatePending(this.solved);

  /// Данные заполнения при открытии экрана
  final List<int> solved;
}

/// Капча успешно решена, [T] - тип возвращаемых данных
class Captcha2StateSolved<T> extends Captcha2State {
  const Captcha2StateSolved(this.response);

  final T response;
}
