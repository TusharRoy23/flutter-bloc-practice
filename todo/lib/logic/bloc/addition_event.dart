part of 'addition_bloc.dart';

abstract class AdditionEvent extends Equatable {}

class GetTransactionListEvent extends AdditionEvent {
  GetTransactionListEvent();
  @override
  List<Object> get props => [];
}

class TransactionListEvent extends AdditionEvent {
  TransactionListEvent();
  @override
  List<Object> get props => [];
}

class DoTransactionEvent extends AdditionEvent {
  final num amount;

  DoTransactionEvent(this.amount);
  @override
  List<Object?> get props => [amount];
}
