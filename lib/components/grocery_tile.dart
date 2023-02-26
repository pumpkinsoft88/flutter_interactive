// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';

class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.groceryItem, this.onComplete});

  final GroceryItem groceryItem;
  final void Function(bool?)? onComplete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 60,
              color: groceryItem.color,
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groceryItem.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(DateFormat('MMMM dd h:mm a').format(groceryItem.date)),
                const SizedBox(
                  height: 4,
                ),
                buildImportance()
              ],
            ),
          ],
        ),
        Row(
          children: [
            Text(
              groceryItem.quantity.toString(),
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 24),
            ),
            Checkbox(value: groceryItem.isComplete, onChanged: onComplete)
          ],
        ),
      ],
    );
  }

  Widget buildImportance() {
    switch (groceryItem.importance) {
      case Importance.low:
        return const Text('low', style: TextStyle(fontWeight: FontWeight.w200));
      case Importance.medium:
        return const Text('medium',
            style: TextStyle(fontWeight: FontWeight.w600));
      case Importance.high:
        return const Text('high',
            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.red));
      default:
        throw Exception('There is no such importance value');
    }
  }
}
