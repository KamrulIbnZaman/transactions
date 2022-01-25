import 'package:flutter/material.dart';

import './models/transactions.dart';
import 'widgets/chart.dart';
import './widgets/transactionListView.dart';
import './widgets/newTransaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        primarySwatch: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transactions> _transactionList = [
    Transactions(
      DateTime.now().toString(),
      'New Shoes',
      54.99,
      DateTime.now(),
    ),
    Transactions(
      DateTime.now().toString(),
      'Pant',
      22.99,
      DateTime.now(),
    ),
  ];

  void _addNewTransaction(
    String title,
    double amount,
    DateTime date,
  ) {
    final _newTx = Transactions(
      DateTime.now().toString(),
      title,
      amount,
      date,
    );
    setState(() {
      _transactionList.add(_newTx);
    });
  }

  void _showNewTransactionSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deletSelectedTransaction(String id) {
    setState(
      () {
        _transactionList.removeWhere((element) => element.id == id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Transactions'),
        actions: [
          IconButton(
            onPressed: () => _showNewTransactionSheet(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_transactionList),
            TransactionListView(
              _transactionList,
              _deletSelectedTransaction,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _showNewTransactionSheet(context),
      ),
    );
  }
}
