part of 'addition_bloc.dart';

abstract class AdditionState extends Equatable {}

class AdditionInitial extends AdditionState {
  @override
  List<Object> get props => [];
}

class LoadingState extends AdditionState {
  @override
  List<Object> get props => [];
}

class MoneyState extends AdditionState {
  MoneyState({required this.deposite});
  final num deposite;

  @override
  List<Object> get props => [deposite];
}

class TransactionListState extends AdditionState {
  TransactionListState({required this.transactions});
  final List<TransactionEntity> transactions;
  @override
  List<Object> get props => [transactions];
}

class TransactionState extends AdditionState {
  final num deposite;
  final List<TransactionEntity> transactions;

  TransactionState({
    this.deposite = 0,
    this.transactions = const [],
  });

  TransactionState copyWith({
    num? deposite,
    List<TransactionEntity>? transactions,
  }) {
    return TransactionState(
      deposite: deposite ?? this.deposite,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get props => [deposite, transactions];
}
