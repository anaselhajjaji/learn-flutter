import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  const ChartBar(
      {Key? key,
      required this.label,
      required this.spendingAmount,
      required this.spendingPercentageOfTotal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: layout builder will be used to dynamically get available size for widgets
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.15,
              //TODO: to force the text to fit inside without wrap
              child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              // TODO: use the constraints of the LayoutBuilder here
              height: constraints.maxHeight * 0.6,
              width: 10,
              //TODO: Stack Widget overlaps widgets
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  //TODO: FractionallySizedBox a box with sized percentage
                  FractionallySizedBox(
                    heightFactor: spendingPercentageOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              //TODO: to ensure that the Text will always fit
              child: FittedBox(
                child: Text(label),
              ),
            )
          ],
        );
      },
    );
  }
}
