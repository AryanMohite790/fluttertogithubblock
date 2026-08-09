import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  static const int maxLimit = 10;
  static const int minLimit = 0;

  CounterBloc() : super(const CounterState(count: minLimit)) {
    on<IncrementEvent>((event, emit) {
      if (state.count >= maxLimit) {
        // Force a fresh state emission with the message
        emit(
          CounterState(
            count: state.count,
            snackBarMessage: "Maximum limit reached",
          ),
        );
      } else {
        emit(CounterState(count: state.count + 1));
      }
    });

    on<DecrementEvent>((event, emit) {
      if (state.count > minLimit) {
        emit(CounterState(count: state.count - 1));
      }
    });

    on<ResetEvent>((event, emit) {
      emit(
        const CounterState(
          count: minLimit,
          snackBarMessage: "Counter has been reset!",
        ),
      );
    });
  }
}
