import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/widgets/chartBar.dart';

import '../models/transactions.dart';

class Chart extends StatelessWidget {
  final List<Transactions> _getTransactionList;

  Chart(this._getTransactionList);

  List<Map<String, Object>> get _groupedTrnsValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var _totalSum = 0.0;
      for (var i = 0; i < _getTransactionList.length; i++) {
        if (_getTransactionList[i].date.day == weekDay.day &&
            _getTransactionList[i].date.month == weekDay.month &&
            _getTransactionList[i].date.year == weekDay.year) {
          _totalSum += _getTransactionList[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': _totalSum,
      };
    }).reversed.toList();
  }

  double get _totalSpending {
    return _groupedTrnsValue.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTrnsValue.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                e['day'] as String,
                e['amount'] as double,
                _totalSpending == 0.0
                    ? 0.0
                    : (e['amount'] as double) / _totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
