import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../services/i_service.dart';
import 'captcha2_task_data.dart';

abstract class ICaptcha2Service implements IService {
  /// For implement only
  ICaptcha2Service._();

  static ICaptcha2Service of(BuildContext context) =>
      context.read<ICaptcha2Service>();

  /// Показывает окно с капчей, вызывается когда апи возвращает данные капчи
  /// заместо нормального ответа. [T] - тип данных в запросе на капчу
  Future<void> openCaptchaDialog<T>(Captcha2TaskData<T> data);
}
