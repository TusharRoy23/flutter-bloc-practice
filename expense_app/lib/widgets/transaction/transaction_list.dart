import 'package:flutter/material.dart';
import '../../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
        height: mediaQuery.size.height,
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, constrains) {
                return Column(
                  children: <Widget>[
                    Text(
                      'No transactions yet!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: constrains.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                );
              })
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  // BuildContext is return a Widget
                  return TransactionItem(
                    transaction: this.transactions[index],
                    deleteTx: deleteTx,
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
