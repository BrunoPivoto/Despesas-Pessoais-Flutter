import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double value;
  final double percent;

  const ChartBar({
    required this.day,
    required this.value,
    required this.percent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        //mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 20,
            child: FittedBox(
                child: Text(
              value.toStringAsFixed(2),
              style: const TextStyle(color: Colors.black),
            )),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: constraints.maxHeight * 0.7,
            width: 30,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: percent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(day),
        ],
      );
    });
  }
}
