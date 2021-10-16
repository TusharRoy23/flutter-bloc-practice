import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../adaptive_button.dart';

class AddTransaction extends StatefulWidget {
  final Function addTranxHandler;

  const AddTransaction(this.addTranxHandler);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    final inputedTitle = _titleController.text;
    final inputedAmount = double.parse(_amountController.text);

    if (inputedTitle.isEmpty || inputedAmount <= 0) {
      return;
    }
    widget.addTranxHandler(inputedTitle, inputedAmount, _selectedDate);

    Navigator.of(context).pop(); // close top most screen
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((dateSelected) {
      if (dateSelected == null) {
        return;
      }
      setState(() {
        _selectedDate = dateSelected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  10 // viewInsets typically refered to KEYBOARD
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      // ignore: unnecessary_null_comparison
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Selected Date ${DateFormat.yMd().format(_selectedDate!)}',
                    )),
                    AdaptiveButton(_showDatePicker, 'Choose Date'),
                  ],
                ),
              ),
              RaisedButton(
                child: const Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button!.color,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
