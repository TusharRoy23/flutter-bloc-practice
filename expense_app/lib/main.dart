import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './widgets/chart/chart.dart';
import './widgets/transaction/transaction_list.dart';
import './widgets/transaction/add_transaction.dart';
import './models/transaction.dart';

void main() {
  // For Disable potrait mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ],
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.purpleAccent,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 18 * MediaQuery.textScaleFactorOf(context),
                ),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 20 * MediaQuery.textScaleFactorOf(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 'T1',
    //   title: 'New Books',
    //   amount: 100.00,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'T2',
    //   title: 'New Shoes',
    //   amount: 200.49,
    //   date: DateTime.now(),
    // ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  bool _showChart = false;

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    final newTranx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: selectedDate,
    );

    setState(() => _userTransactions.add(newTranx));
  }

  void _openAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: AddTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Widget> _buildPotraitMode(
      MediaQueryData mediaQuery, PreferredSizeWidget appBar, Widget tnxList) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_userTransactions),
      ),
      tnxList
    ];
  }

  List<Widget> _buildLandscapeMode(
      MediaQueryData mediaQuery, PreferredSizeWidget appBar, Widget tnxList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          )
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_userTransactions),
            )
          : tnxList
    ];
  }

  PreferredSizeWidget _cupertinoNavBar(BuildContext context) {
    return CupertinoNavigationBar(
      middle: const Text(
        'Personal Expenses',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: const Icon(CupertinoIcons.add),
            onTap: () => _openAddNewTransaction(context),
          )
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Personal Expenses',
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _openAddNewTransaction(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _islandScape = mediaQuery.orientation == Orientation.landscape;

    // final PreferredSizeWidget appBar = WidgetVariables(_openAddNewTransaction);
    final PreferredSizeWidget appBar =
        Platform.isIOS ? _cupertinoNavBar(context) : _appBar(context);

    final Widget tnxList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    var pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (_islandScape) ..._buildLandscapeMode(mediaQuery, appBar, tnxList),
          if (!_islandScape) ..._buildPotraitMode(mediaQuery, appBar, tnxList),
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar as ObstructingPreferredSizeWidget)
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _openAddNewTransaction(context),
                    child: const Icon(Icons.add),
                  ),
          );
  }
}
