import 'dart:io';
import 'package:example_max4/provider/tran_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:example_max4/widgets/chart.dart';
import 'package:provider/provider.dart';
import 'package:example_max4/widgets/new_Transaction.dart';
import 'package:example_max4/widgets/transaction_List.dart';
import 'package:flutter/material.dart';


class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool showChart = false;

  @override
  Widget build(BuildContext context) {
    final Prov = Provider.of<TranProvider>(context, listen: false);
//
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
      middle: Text("Personal Expenses"),
      trailing: IconButton(
          icon: Icon(Icons.add),
          onPressed: () => Prov.startAddNewTransaction(context,)),
    )
        : AppBar(
      title: Text("Personal Expenses"),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Prov.startAddNewTransaction(context))
      ],
    );

    final txListWidget = Container(
        height: (MediaQuery
            .of(context)
            .size
            .height -
            appBar.preferredSize.height -
            MediaQuery
                .of(context)
                .padding
                .top) *
            0.7,
        child: TransactionList());
//    Prov.userTransaction, Prov.deleteTransaction
    final island = MediaQuery
        .of(context)
        .orientation == Orientation.landscape;

    final pageBody = SafeArea(
      child: FutureBuilder(
          future:
          Provider
              .of<TranProvider>(context, listen: false)
              .recentTransaction,

          builder: (ctx, snapshot) {


            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
              child: CircularProgressIndicator(),
            )
                : SingleChildScrollView(
              child: Column(
                children: [
                  if (island)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Show Chart"),
                        Switch.adaptive(
                            value: showChart,
                            onChanged: (val) {
                              setState(() {
                                showChart = val;
                              });
                            })
                      ],
                    ),
                  if (!island)Container(
                            height: (MediaQuery
                                .of(context)
                                .size
                                .height -
                                appBar.preferredSize.height -
                                MediaQuery
                                    .of(context)
                                    .padding
                                    .top) *
                                0.3,
                            child:
                                Chart()),

                  if (!island) txListWidget,
                  if (island)
                    showChart == true
                        ?
                          Container(
                              height: (MediaQuery
                                  .of(context)
                                  .size
                                  .height -
                                  appBar.preferredSize.height -
                                  MediaQuery
                                      .of(context)
                                      .padding
                                      .top) *
                                  0.8,
                              child:Chart()

                    )
                        : txListWidget,
                ],
              ),
            );
          }
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
      child: pageBody,
      navigationBar: appBar,
    )
        : Scaffold(
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Prov.startAddNewTransaction(context),
      ),
      appBar: appBar,
      body: pageBody,
    );
  }
}
