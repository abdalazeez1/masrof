import 'package:example_max4/provider/tran_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   final prov =Provider.of<TranProvider>(context);
   final transaction=prov.userTransaction;
    return transaction.isEmpty
        ? LayoutBuilder(builder: (ctx, covariant) {
            return Container(
              width: covariant.maxWidth,
              child: Column(

                children: [
                  Text(
                    'No transaction add yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: covariant.maxHeight * 0.6,
                      child: Image.asset('asset/images/waiting.png'))
                ],
              ),
            );
          })
        : ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                          child: Text("\$${transaction[index].amount}")),
                    ),
                  ),
                  title: Text(
                    transaction[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transaction[index].time)),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => prov.deleteTransaction(transaction[index].id)),
//                    deleteTX(transaction[index].id)
                ),
              );
            },
          );
  }
}
// tow

//Card(
//child: Row(
//children: [
//Container(
//margin: EdgeInsets.symmetric(
//vertical: 10, horizontal: 15),
//decoration: BoxDecoration(
////                              color: Colors.purple,
//border: Border.all(
//color: Theme.of(context).primaryColor,
//width: 2,
//),
//),
//padding: EdgeInsets.all(10),
//child: Text(
//transaction[index].amount.toStringAsFixed(2),
//style: TextStyle(
//fontWeight: FontWeight.bold,
//fontSize: 20,
//color:Theme.of(context).primaryColor),
//),
//),
//
//Column(
//crossAxisAlignment: CrossAxisAlignment.start,
//children: [
//Text(
//transaction[index].title,
//style:Theme.of(context).textTheme.title
//),
//Text(
//DateFormat.yMMMd().format( transaction[index].time),
//style: TextStyle(color: Colors.grey),
//),
//],
//)
//],
//),
//)
