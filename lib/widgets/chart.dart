import 'package:example_max4/models/transaction.dart';
import 'package:example_max4/provider/tran_provider.dart';
import 'package:example_max4/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class Chart extends StatefulWidget {


//  final Future<List<Map<String,dynamic>>> recentTransaction;
//
//  const Chart({Key key, this.recentTransaction}) : super(key: key);
//



  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
 List<Transactions> userTransaction=[];

bool _isl=true;

  @override
  void didChangeDependencies()async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(_isl){
      final prov= Provider.of<TranProvider>(context);
       userTransaction= prov.userTransaction;

       _isl=false;
    }
  }

 List<Map<String, Object>> get gropedTransactionValue  {
   return List.generate(7, (index) {
     final weekDay = DateTime.now().subtract(Duration(days: index));//احد تنين تلاتاء اربعاء خميس

     var totalSum = 0.0;

     for (var i = 0; i < userTransaction.length; i++) {
       if (userTransaction[i].time.day == weekDay.day &&
           userTransaction[i].time.month == weekDay.month &&
           userTransaction[i].time.year == weekDay.year) {
         totalSum += userTransaction[i].amount;

       }
//print('totla sum');
//       print(totalSum);

     }
     return {

       'day': DateFormat.E().format(weekDay).substring(0, 1),
       'amount': totalSum
     };
   });
 }

 double get totalSpending  {
   return gropedTransactionValue.fold(
       0.0, (sum, item) {
//         print('sum');
//         print(sum);
         return sum + item['amount'];
   });


 }

  @override
  Widget build(BuildContext context) {
    BuildContext d;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:gropedTransactionValue.map(
            (e) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: e['day'],
                  spending: e['amount'],
                  spendingPofTotal: totalSpending == 0.0
                      ? 0.0
                      : (e['amount'] as double) / totalSpending,
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
//gropedTransactionValue.map((e) {
//return CahrtBar(label: e['day'],spending: e['amount'],spendingPofTotal:(e['amount']as double)/ totalSpending,);
//}).toList(),
