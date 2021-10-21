import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_repository/money_repository.dart';
import 'package:todo/logic/bloc/addition_bloc.dart';
import 'package:todo/widgets/custom_input_field.dart';
//import './logic/cubit/addition_cubit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final TextEditingController _depositeController;
  late final TextEditingController _withdrawController;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    _depositeController = TextEditingController();
    _withdrawController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomInputField(
              controller: _depositeController,
              hintText: 'Deposite',
            ),
            ElevatedButton(
              onPressed: () {
                if (_depositeController.text.isNotEmpty) {
                  counter = int.parse(_depositeController.value.text);
                  // BlocProvider.of<AdditionCubit>(context).doDeposite(counter);
                  BlocProvider.of<AdditionBloc>(context)
                      .add(DoTransactionEvent(counter));
                  _depositeController.clear();
                }
              },
              child: Text('Deposite'),
            ),
            SizedBox(
              height: 20,
            ),
            CustomInputField(
              controller: _withdrawController,
              hintText: 'Withdraw',
            ),
            ElevatedButton(
              onPressed: () {
                if (_withdrawController.text.isNotEmpty) {
                  counter = int.parse(_withdrawController.value.text);
                  // BlocProvider.of<AdditionCubit>(context).doWithdraw(counter);
                  BlocProvider.of<AdditionBloc>(context)
                      .add(DoTransactionEvent(-counter));
                  _withdrawController.clear();
                }
              },
              child: Text('Withdraw'),
            ),
            SizedBox(
              height: 20,
            ),
            BlocConsumer<AdditionBloc, AdditionState>(
              builder: (ctx, state) {
                if (state is TransactionState) {
                  return Text(
                    'Total count: ${state.deposite}',
                    style: TextStyle(fontSize: 20),
                  );
                }
                return Center();
              },
              listener: (ctx, state) {},
            ),

            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // BlocProvider.of<AdditionCubit>(context).transactionList();
                BlocProvider.of<AdditionBloc>(context)
                    .add(TransactionListEvent());
              },
              child: Icon(Icons.search),
            ),
            BlocConsumer<AdditionBloc, AdditionState>(
              builder: (ctx, state) {
                if (state is LoadingState)
                  return Center(child: CircularProgressIndicator());
                if (state is TransactionState) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (ctx, int index) {
                      var item = state.transactions[index];
                      return Text('${item.amount}');
                    },
                    itemCount: state.transactions.length,
                  );
                }
                return Center();
              },
              listener: (ctx, state) {},
            ),
            // BlocConsumer<AdditionCubit, AdditionState>(
            //   builder: (ctx, state) {
            //     if (state is LoadingState)
            //       return Center(child: CircularProgressIndicator());
            //     if (state is TransactionListState) {
            //       return ListView.builder(
            //         scrollDirection: Axis.vertical,
            //         shrinkWrap: true,
            //         itemBuilder: (ctx, int index) {
            //           var item = state.transactions[index];
            //           return Text('${item.amount}');
            //         },
            //         itemCount: state.transactions.length,
            //       );
            //     }
            //     return Center();
            //   },
            //   listener: (ctx, state) {},
            // ),
          ],
        ),
      ),
    );
  }
}
