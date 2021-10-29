part of 'counter_cubit.dart';

class CounterState extends Equatable {
  final int counterValue;

  CounterState({
    required this.counterValue,
  });

  @override
  List<Object?> get props => [this.counterValue];

  Map<String, dynamic> toMap() {
    // storing data
    return {
      'counterValue': counterValue,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    // getting data
    return CounterState(
      counterValue: map['counterValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source));
}
