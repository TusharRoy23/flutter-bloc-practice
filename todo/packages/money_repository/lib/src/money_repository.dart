import 'package:money_repository/src/models/transaction.dart';

abstract class MoneyRepository {
  Future<void> doDeposite(num amount);
  Future<void> doWithdraw(num amount);
  Future<void> doTransaction(num amount);
  Future<void> transactionList();
}
