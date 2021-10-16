import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import './models/transaction.dart';

import './money_repository.dart';
import 'constants/datetime_formatter.dart';

class FirebaseMoneyRepository implements MoneyRepository {
  CollectionReference _transaction =
      FirebaseFirestore.instance.collection('transactions');
  @override
  Future<String> doDeposite(num amount) async {
    return _transaction
        .add({
          'amount': amount,
          'date': DateTime.now(),
        })
        .then((value) => value.id)
        .catchError((error) => error);
  }

  @override
  Future<String> doWithdraw(num amount) {
    return _transaction
        .add({
          'amount': -amount,
          'date': DateTime.now(),
        })
        .then((value) => value.id)
        .catchError((error) => error);
  }

  @override
  Future<dynamic> transactionList() async {
    var list = [];
    return _transaction.get().then((value) {
      value.docs.forEach(
        (item) {
          var value = (item.data() as Map);
          list.add(
            TransactionEntity(
              id: item.id,
              amount: value['amount'],
              date: DatetimeFormatter.datetimeToDate(
                DateTime.fromMicrosecondsSinceEpoch(
                  value['date'].microsecondsSinceEpoch,
                ),
                'dd MMM yyyy',
              ),
            ),
          );
        },
      );
      return list;
    }).catchError((error) => error);
  }

  // @override
  // Stream<List<Transaction>> transactionList() {
  //   // return _transaction
  //   //     .get()
  //   //     .then((value) => value)
  //   //     .catchError((error) => error);
  //   return _transaction.snapshots().map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       return Transaction(
  //         id: doc.id,
  //         amount: 20.5,
  //         date: 'abcd',
  //       );
  //     }).toList();
  //   });
  // }

  //  fromEntity(TodoEntity entity) {
  //   return Todo(
  //     id: entity.id,
  //     task: entity.task,
  //     complete: entity.complete,
  //     note: entity.note,
  //   );
  // }
}
