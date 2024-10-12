import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [BaseCubit] is a base cubit for the project.
/// It is used to prevent the state from being emitted after the widget is disposed.
abstract class BaseCubit<T extends Object> extends Cubit<T> {
  /// [BaseCubit] constructor.
  ///
  /// The [initialState] parameter is required.
  ///
  /// * The [initialState] parameter is the initial state of the cubit.
  BaseCubit(super.initialState);

  /// [initialEvent] is a function that will be called when the cubit is initialized.
  void initialEvent({BuildContext? context});

  @override
  void emit(T state) {
    if (isClosed) return;
    super.emit(state);
  }
}
