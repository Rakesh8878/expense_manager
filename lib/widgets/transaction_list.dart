import 'package:expense_manager/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  
  final List<Transaction> transcations;

  TransactionList(this.transcations);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
          child: transcations.isEmpty ? Column(
            children: <Widget>[
              Text("No Transaction added yet!", style: Theme.of(context).textTheme.title),
              SizedBox(height: 10,),
              Container(
                height: 200,
                child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,),
              ),
            ],
          ) : ListView.builder(
            itemBuilder: (BuildContext context, int index){
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
                              child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                                        child: FittedBox(
                        child: Text('${transcations[index].amount.toStringAsFixed(2)}', ),
                      ),
                    ),
                  ),
                  title: Text(transcations[index].title, 
                  style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(DateFormat('dd-MM-yyyy').format(transcations[index].date),
                  ),
                  trailing: null,
                ),
              );
              // return Card(
              //     child: Row(
              //       children: <Widget>[
              //         Container(
              //           margin:
              //               EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              //           padding: EdgeInsets.all(10),
              //           decoration: BoxDecoration(
              //               border: Border.all(
              //             color: Theme.of(context).primaryColor,
              //             width: 2,
              //           )),
              //           child: Text(
              //             '${transcations[index].amount.toStringAsFixed(2)}',
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 20,
              //                 color: Theme.of(context).primaryColor),
              //           ),
              //         ),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             Text(
              //               transcations[index].title,
              //               style: TextStyle(
              //                   fontSize: 15, fontWeight: FontWeight.bold),
              //             ),
              //             Text(
              //               DateFormat('dd-MM-yyyy').format(transcations[index].date),
              //               style: TextStyle(color: Colors.grey),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   );
            },
            itemCount: transcations.length,
            ),
    );
  }
}