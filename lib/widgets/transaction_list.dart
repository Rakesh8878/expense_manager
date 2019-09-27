import 'package:expense_manager/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transcations;
  final Function deleteTransaction;

  TransactionList(this.transcations, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transcations.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: <Widget>[
                    Text("No Transaction added yet!",
                        style: Theme.of(context).textTheme.title),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '${transcations[index].amount.toStringAsFixed(2)}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transcations[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat('dd-MM-yyyy').format(transcations[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460 ? IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      onPressed: () =>
                          deleteTransaction(transcations[index].id),
                    ) 
                    : FlatButton.icon(
                      icon: Icon(Icons.delete),
                      textColor: Colors.red,
                      label: Text("Delete"),
                      onPressed: () => deleteTransaction(transcations[index].id),
                    ),
                  ),
                );
              },
              itemCount: transcations.length,
            ),
    );
  }
}
