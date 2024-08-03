import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit(super.initialState);

  void increment() => emit(CounterState(state.value + 1, true));

  void decrement() => emit(CounterState(state.value - 1, false));
}

// That's a temp solution for this model
class CounterState {
  final int value;
  final bool isIncremented;

  CounterState(this.value, this.isIncremented);
}