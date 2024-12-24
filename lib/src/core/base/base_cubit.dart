import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/mb_adapty_configuration.dart';

/// [BaseCubit] is a base cubit for the project.
/// It is used to prevent the state from being emitted after the widget is disposed.
abstract class BaseCubit<T extends Object> extends Cubit<T> {
  /// [BaseCubit] constructor.
  ///
  /// The [initialState] parameter is required.
  ///
  /// * The [initialState] parameter is the initial state of the cubit.
  BaseCubit(super.initialState);

  /// [initAdapty] is used to initialize Adapty. It is an abstract method.
  /// The [configuration] parameter is required.
  Future<void> initAdapty(MBAdaptyConfiguration configuration);

  @override
  void emit(T state) {
    if (isClosed) return;
    super.emit(state);
  }
}
