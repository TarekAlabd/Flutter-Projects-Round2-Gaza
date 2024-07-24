import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

class CounterEvent {}

class CounterIncrement extends CounterEvent {}

class CounterDecrement extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrement>((event, emit) => emit(state + 1));
    on<CounterDecrement>(_decrementCounter);
  }

  void _decrementCounter(CounterDecrement event, Emitter<int> emit) {
    emit(state - 1);
  }
}

void main(List<String> arguments) {
  final bloc = CounterBloc();
  print(bloc.state);
  bloc.stream.listen(print);
  bloc.add(CounterIncrement());
  bloc.add(CounterIncrement());
  bloc.add(CounterIncrement());
  bloc.add(CounterDecrement());
  bloc.add(CounterDecrement());
  bloc.close();

  bloc.add(CounterIncrement());

  // final cubit = CounterCubit();
  // print(cubit.state);
  // cubit.stream.listen(print);
  // cubit.increment();
  // cubit.decrement();
  // cubit.decrement();
  // cubit.decrement();
  // cubit.close();
}
