// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction tr;
  final Function(String) onRemove;

  const TransactionItem({
    required this.tr,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text('R\$${tr.value.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          tr.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(DateFormat('d MMM y').format(tr.date)),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                onPressed: () => onRemove(tr.id.toString()),
                icon: const Icon(Icons.delete),
                label: const Text('Excluir'),
                style:
                    TextButton.styleFrom(primary: Theme.of(context).errorColor),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => onRemove(tr.id.toString()),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
