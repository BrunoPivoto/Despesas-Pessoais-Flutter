import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  final Transaction tr;
  final void Function(String) onRemove;

  const TransactionItem({
    Key? key,
    required this.tr,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    //Colors.red,
    // Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.amber,
    Colors.black,
  ];

  Color? _backgroundColor;
  @override
  void initState() {
    super.initState();
    int i = Random().nextInt(4);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _backgroundColor,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                child: Text(
                  'R\$${widget.tr.value.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            widget.tr.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(
            DateFormat('d MMM y', 'pt_BR').format(widget.tr.date),
          ),
          trailing: //MediaQuery.of(context).size.width > 480
              //?
              TextButton.icon(
            onPressed: () => widget.onRemove(widget.tr.id),
            label: Text(
              'Remover',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            icon:
                Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
          )
          // : IconButton(
          //     icon: const Icon(Icons.delete),
          //     color: Theme.of(context).colorScheme.error,
          //     onPressed: () => onRemove(tr.id),
          //   ),
          ),
    );
  }
}
