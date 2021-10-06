part of 'counter_cubit.dart';

class CounterState extends Equatable {
  final int counterValue;

  CounterState({
    required this.counterValue,
  });

  @override
  List<Object> get props => [counterValue];

  CounterState copyWith({
    int? counterValue,
  }) {
    return CounterState(
      counterValue: counterValue ?? this.counterValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'counterValue': counterValue,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      counterValue: map['counterValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source));

  @override
  String toString() => 'CounterState(counterValue: $counterValue)';
}
