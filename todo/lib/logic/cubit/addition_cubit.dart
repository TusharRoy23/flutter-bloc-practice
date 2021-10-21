import 'dart:developer';

// import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:money_repository/money_repository.dart';

part 'addition_state.dart';

class AdditionCubit extends Cubit<AdditionState> {
  final FirebaseMoneyRepository moneyRepository;

  AdditionCubit({required this.moneyRepository}) : super(InitialState()) {
    transactionList();
  }

  void doDeposite(num value) {
    final currentState = state;
    if (currentState is MoneyState) {
      var amount = currentState.deposite + value;
      moneyRepository.doDeposite(amount);

      emit(
        MoneyState(deposite: amount),
      );
      transactionList();
    }
  }

  void doWithdraw(num value) {
    final currentState = state;
    if (currentState is MoneyState) {
      var amount = currentState.deposite - value;
      moneyRepository.doWithdraw(amount);
      emit(
        MoneyState(deposite: amount),
      );
      transactionList();
    }
  }

  void transactionList() async {
    try {
      emit(LoadingState());
      final list = await moneyRepository.transactionList();

      emit(TransactionListState(transactions: [...list]));
    } catch (e) {}
  }
}
