import 'package:provider/provider.dart';

import 'captcha2_service_interface.dart';

abstract class Captcha2ServiceBase implements ICaptcha2Service {
  Provider<ICaptcha2Service> get provider {
    assert(() {
      final previous = Provider.debugCheckInvalidValueType;
      Provider.debugCheckInvalidValueType = <T>(value) {
        if (T == ICaptcha2Service) return;
        previous?.call<T>(value);
      };
      return true;
    }(), 'disable warning for listnabel provided value');

    return Provider<ICaptcha2Service>(
      create: (context) => this..init(),
      dispose: (context, service) => service.dispose(),
    );
  }
}
