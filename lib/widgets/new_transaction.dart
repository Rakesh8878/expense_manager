import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransaction extends StatefulWidget {

  final Function addnewTranscation;
  // String titleInput;
  // String amountInput;

  NewTransaction(this.addnewTranscation);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInputController = TextEditingController();

  final amountInputController = TextEditingController();

  void addExpense(){
    final titleInput = this.titleInputController.text;
    final amountInput = double.parse(this.amountInputController.text);
    if(titleInput.isEmpty || amountInput <= 0){
      return;
    }
    widget.addnewTranscation(this.titleInputController.text, double.parse(this.amountInputController.text));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Title"
                    ),
                    //  onChanged: (value) => this.titleInput = value,
                    controller: this.titleInputController,
                    onSubmitted: (_) => addExpense(),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Amount"
                    ),
                    //  onChanged: (value) => this.amountInput = value,
                    controller: this.amountInputController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => addExpense(),
                  ),
                  FlatButton(
                    onPressed: addExpense,
                    child: Text("Add Transaction"),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          );
  }
}