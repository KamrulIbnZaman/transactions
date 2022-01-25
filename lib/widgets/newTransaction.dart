import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleConatroler = TextEditingController();
  final _amountControler = TextEditingController();
  var _selectedDate;

  void _submitData() {
    if (_amountControler.text.isEmpty) {
      return;
    }

    final _enterdTitle = _titleConatroler.text;
    final _enteredAmount = double.parse(_amountControler.text);

    if (_enterdTitle.isEmpty || _enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      _enterdTitle,
      _enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presetDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleConatroler,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountControler,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date has been chosen!'
                          : '${DateFormat.yMd().format(_selectedDate)} has been chosen!',
                    ),
                  ),
                  FlatButton(
                    onPressed: _presetDatePicker,
                    child: Text('Pick a Date'),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: _submitData,
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
