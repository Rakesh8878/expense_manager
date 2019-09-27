import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addnewTranscation;
  // String titleInput;
  // String amountInput;

  NewTransaction(this.addnewTranscation);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInputController = TextEditingController();
  final _amountInputController = TextEditingController();
  DateTime _seletedDate;

  void _addExpense() {
    if (this._amountInputController.text.isEmpty) {
      return;
    }
    final titleInput = this._titleInputController.text;
    final amountInput = double.parse(this._amountInputController.text);
    if (titleInput.isEmpty || amountInput <= 0 || _seletedDate == null) {
      return;
    }
    widget.addnewTranscation(this._titleInputController.text,
        double.parse(this._amountInputController.text), _seletedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _seletedDate = pickedDate;
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
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                //  onChanged: (value) => this.titleInput = value,
                controller: this._titleInputController,
                onSubmitted: (_) => _addExpense(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                //  onChanged: (value) => this.amountInput = value,
                controller: this._amountInputController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _addExpense(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _seletedDate == null
                            ? 'No date chosen'
                            : 'Picked date: ${DateFormat.yMd().format(_seletedDate)}',
                      ),
                    ),
                    FlatButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _addExpense,
                child: Text("Add Transaction"),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
