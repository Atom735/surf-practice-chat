// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:meta/meta.dart';

@immutable
class Captcha2TaskData<T> {
  const Captcha2TaskData(this.data, this.desc);

  /// Данные поставляемые которые необходимо выбрать
  final List<T> data;

  /// Описание по которому должен происходить выбор
  final String desc;

  @override
  String toString() {
    var s = '';
    assert(() {
      s = 'Captcha2TaskData(data: $data, desc: $desc)';
      return true;
    }(), 'toString() only on debug');
    return s;
  }
}
