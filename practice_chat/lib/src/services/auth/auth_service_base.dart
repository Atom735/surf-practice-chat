import 'package:provider/provider.dart';

import 'auth_interface.dart';

mixin AuthServiceBase implements IAuthService {
  Provider<IAuthService> get provider {
    assert(() {
      final previous = Provider.debugCheckInvalidValueType;
      Provider.debugCheckInvalidValueType = <T>(value) {
        if (T == IAuthService) return;
        previous?.call<T>(value);
      };
      return true;
    }(), 'disable warning for listnabel provided value');

    return Provider<IAuthService>(
      create: (context) => this..init(),
      dispose: (context, service) => service.dispose(),
    );
  }
}
