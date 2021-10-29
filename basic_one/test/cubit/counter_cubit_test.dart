// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import '../../lib/cubit/counter_cubit.dart';

// void main() {
//   group('CounterCubit', () {
//     CounterCubit? counterCubit;

//     setUp(() {
//       counterCubit = CounterCubit();
//     });

//     tearDown(() {
//       counterCubit!.close();
//     });

//     test('initial state of CounterCubic is CounterState(counterValue:0)', () {
//       expect(counterCubit!.state, CounterState(counterValue: 0));
//     });

//     // blocTest(
//     //   'the CounterCubit should emit a CounterState(counterValue:1, wasIncremented:true) when the increment function is called',
//     //   build: () => counterCubit,
//     //   act: (cubit) => cubit!.increment(),
//     //   expect: [CounterState(counterValue: 1)],
//     // );
//   });
// }
