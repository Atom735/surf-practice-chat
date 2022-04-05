abstract class IService {
  /// For implement only
  IService._();

  void init();

  void dispose();
}

abstract class IServiceWithState<State> implements IService {
  /// For implement only
  IServiceWithState._();

  State get state;
  Stream<State> get stream;
}
