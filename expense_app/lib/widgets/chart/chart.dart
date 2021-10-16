import 'package:expense_app/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      // final today = DateTime.now();
      // final weekDayNumber = today.weekday;
      // final weekDay = today.subtract(
      //   Duration(days: weekDayNumber - index - 1),
      // );
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (var tx in recentTransactions) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalSum += tx.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get _spentTotal {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      double amount = item['amount'] as double;
      return sum + amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  data['day'] as String,
                  data['amount'] as double,
                  _spentTotal == 0.0
                      ? 0.0
                      : (data['amount'] as double) / _spentTotal,
                ));
          }).toList(),
        ),
      ),
    );
  }
}
