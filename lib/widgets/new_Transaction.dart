import 'package:example_max4/models/transaction.dart';
import 'package:example_max4/provider/tran_provider.dart';
import 'package:example_max4/widgets/input_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class NewTransaction extends StatefulWidget {
//INPUT
//  final Function addTX;
//
//
//  NewTransaction(this.addTX);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  bool isp=true;
   Function prov=(){};
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  if(isp){
 prov = Provider.of<TranProvider>(context,listen: false).addNewTransaction;
    isp=false;
  }
  }
  DateTime _selectedDate;
  final titleInput = TextEditingController();

  final amountInput = TextEditingController();

  void _PercentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if(value==null){return;}
      setState(() {
        _selectedDate=value;
      });
    });
  }

  void submited() {
    if(amountInput.text==null){return;}

    final enterdTitle = titleInput.text;
    final enterdAmount = double.parse(amountInput.text);
    if (enterdAmount < 0 || enterdTitle.isEmpty||_selectedDate==null) {
      return;
    }
       prov(titleInput.text, double.parse(amountInput.text),_selectedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Card(
        elevation: 5,
        child: Container(

          padding: EdgeInsets.only(top: 10,right: 10,left: 10,bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleInput,
                onSubmitted: (_) => submited(),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountInput,
                onSubmitted: (_) => submited(),
              ),
              Container(
                height: 70,
                child: Row(

                  children: [
                   Expanded(child: Text(_selectedDate==null? 'No Date Chosen!':'Picked Date : ${DateFormat.yMd().format(_selectedDate)}')),
                    

                    FlatButton(
                      onPressed: _PercentDatePicker,
                      child: Text(
                        'Chose Date ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InputImage(),
              ),
              RaisedButton(
                  onPressed: submited,
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  child: Text(
                    'Add Transaction',
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
