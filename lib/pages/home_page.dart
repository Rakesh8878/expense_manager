import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/widgets/new_transaction.dart';
import 'package:expense_manager/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Transaction> _userTranscations = [
    Transaction(id: 't1', title: 'New Shoe', amount: 500, date: DateTime.now()),
    Transaction(id: 't2', title: 'Grocery', amount: 1000, date: DateTime.now())
  ];

  void _addnewTranscation(String tilte, double amount){
    final newTxn = Transaction(title: tilte, amount: amount, date: DateTime.now(), id: DateTime.now().toString());
    setState(() {
     this._userTranscations.add(newTxn);
    });
  }

  void _startAddNewTransaction(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(_addnewTranscation);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
            ),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text("Chart"),
                elevation: 5,
              ),
            ),
            TransactionList(_userTranscations),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(
          Icons.add_circle_outline
        ),
      ),
    );
  }
}
