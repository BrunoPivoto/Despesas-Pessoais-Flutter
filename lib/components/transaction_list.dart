// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List transactions;
  final Function(String) onDelete;

  const TransactionList(
      {required this.transactions, super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.1,
                    child: Text(
                      'Nenhuma transação',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.5,
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
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  //visualDensity: const VisualDensity(vertical: 4),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FittedBox(
                          child: Text(
                        'R\$${tr.value.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      )),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle:
                      Text(DateFormat('d MMM y', 'pt_BR').format(tr.date)),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? TextButton.icon(
                          onPressed: () => onDelete(tr.id),
                          icon: const Icon(Icons.delete),
                          label: const Text('Remover'),
                          style: ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(
                                  Theme.of(context).colorScheme.error)),
                        )
                      : IconButton(
                          onPressed: () => onDelete(tr.id),
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).colorScheme.error,
                        ),
                ),
              );
            },
          );
  }
}
