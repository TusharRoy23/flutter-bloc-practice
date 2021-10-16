part of 'addition_cubit.dart';

abstract class AdditionState extends Equatable {}

class InitialState extends AdditionState {
  @override
  List<Object> get props => [];
}

class LoadingState extends AdditionState {
  @override
  List<Object> get props => [];
}

class MoneyState extends AdditionState {
  MoneyState({required this.deposite}) {
    log('deposite: $deposite');
  }
  final num deposite;

  @override
  List<Object> get props => [deposite];
}

class TransactionListState extends AdditionState {
  TransactionListState({required this.transactions}) {
    log('transactions const $transactions');
  }
  final List<TransactionEntity> transactions;

  // TransactionListState copyWith({
  //   required List<TransactionEntity> transactions,
  // }) {
  //   log('transactions list $transactions');
  //   return TransactionListState(
  //     transactions: transactions,
  //   );
  // }

  @override
  List<Object> get props => [transactions];
}
