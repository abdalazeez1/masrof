import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spending;
  final double spendingPofTotal;

  ChartBar({this.label, this.spending, this.spendingPofTotal});

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context, covariant) {
      return Column(
        children: [
          Container(
              height: covariant.maxHeight * 0.15,
              child: FittedBox(
                child: Text("\$${spending.toStringAsFixed(0)}"),
              )),
          SizedBox(
            height: covariant.maxHeight * 0.05,
          ),
          Container(
            height: covariant.maxHeight * 0.6,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [

                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey
                          , width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPofTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),

              ],
            ),
          ),
          SizedBox(
            height: covariant.maxHeight * 0.05,
          ),
          Container(
              height: covariant.maxHeight * 0.15,
              child: FittedBox(child: Text(label))),
        ],
      );
    });
  }
}
