import 'dart:io';

import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/widgets/chart.dart';
import 'package:expense_manager/widgets/new_transaction.dart';
import 'package:expense_manager/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _showChart = false;
  final List<Transaction> _userTranscations = [
    // Transaction(id: 't1', title: 'New Shoe', amount: 500, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Grocery', amount: 1000, date: DateTime.now())
  ];

  List<Transaction> get _recentTransaction {
    return _userTranscations.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addnewTranscation(String tilte, double amount, DateTime choosenDate) {
    final newTxn = Transaction(
        title: tilte,
        amount: amount,
        date: choosenDate,
        id: choosenDate.toString());
    setState(() {
      this._userTranscations.add(newTxn);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      this._userTranscations.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(_addnewTranscation);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape =
        mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text("Home Page"),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_circle_outline,
          ),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    final txnListWidget = Container(
      height: (mediaQuery.size.height - mediaQuery.padding.top - appBar.preferredSize.height) * 0.7,
      child: TransactionList(_userTranscations, deleteTransaction),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (isLandScape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              mediaQuery.padding.top -
                              appBar.preferredSize.height) *
                          0.7,
                      child: Chart(_recentTransaction),
                    )
                  : txnListWidget,
            if (!isLandScape)
              Container(
                height: (mediaQuery.size.height -
                        mediaQuery.padding.top -
                        appBar.preferredSize.height) *
                    0.3,
                child: Chart(_recentTransaction),
              ),
            if (!isLandScape) txnListWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: Platform.isIOS ? Container()
      : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add_circle_outline),
      ),
    );
  }
}
