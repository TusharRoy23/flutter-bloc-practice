// import 'package:meta/meta.dart';
import 'dart:async';

import 'package:basic_one/constants/enums.dart';
import 'package:basic_one/logic/cubit/internet_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  late StreamSubscription internetStreamSubscription;

  CounterCubit({
    required this.internetCubit,
  }) : super(CounterState(counterValue: 0)) {
    monitorInternetCubit();
  }

  StreamSubscription<InternetState> monitorInternetCubit() {
    return internetStreamSubscription =
        internetCubit.stream.listen((internetState) {
      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Wifi) {
        increment();
      } else if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Mobile) {
        decrement();
      }
    });
  }

  void increment() => emit(
        CounterState(counterValue: state.counterValue + 1),
      );

  void decrement() => emit(
        CounterState(counterValue: state.counterValue - 1),
      );

  @override
  Future<void> close() {
    internetStreamSubscription.cancel();
    return super.close();
  }
}
