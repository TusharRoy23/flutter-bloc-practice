import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:money_repository/money_repository.dart';

part 'addition_event.dart';
part 'addition_state.dart';

class AdditionBloc extends Bloc<AdditionEvent, AdditionState> {
  final FirebaseMoneyRepository _moneyRepository;

  AdditionBloc(this._moneyRepository) : super(TransactionState()) {
    on<GetTransactionListEvent>(_onGetTransaction);
    on<DoTransactionEvent>(_doTransaction);
    on<TransactionListEvent>(_getTransactionList);
  }

  void _onGetTransaction(
      GetTransactionListEvent event, Emitter<AdditionState> emit) async {
    try {
      emit(LoadingState());
      final list = await _moneyRepository.transactionList();
      emit(
        TransactionState(deposite: 0, transactions: [...list]),
      );
    } catch (e) {}
  }

  void _getTransactionList(
      TransactionListEvent event, Emitter<AdditionState> emit) async {
    try {
      final list = await _moneyRepository.transactionList();
      var currentState = this.state;
      if (currentState is TransactionState) {
        emit(
          currentState.copyWith(transactions: [...list]),
        );
      }
    } catch (e) {}
  }

  void _doTransaction(
      DoTransactionEvent event, Emitter<AdditionState> emit) async {
    final amount = event.amount;
    try {
      await _moneyRepository.doTransaction(amount);
      var currentState = this.state;
      if (currentState is TransactionState) {
        emit(
          currentState.copyWith(deposite: amount),
        );
      }
    } catch (e) {}
  }
}
