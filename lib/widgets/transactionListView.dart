import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionListView extends StatelessWidget {
  final List<Transactions> _getTransactionList;
  final Function _deletTransaction;

  TransactionListView(
    this._getTransactionList,
    this._deletTransaction,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 510,
      child: _getTransactionList.isEmpty
          ? Column(
              children: [
                Text(
                  'No transaction found!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assests/images/Waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, Index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '\$${_getTransactionList[Index].amount}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      '${_getTransactionList[Index].title}',
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd()
                          .format(_getTransactionList[Index].date)
                          .toString(),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () =>
                          _deletTransaction(_getTransactionList[Index].id),
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  ),
                );
              },
              itemCount: _getTransactionList.length,
            ),
    );
  }
}
