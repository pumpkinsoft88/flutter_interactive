// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';

class GroceryTile extends StatelessWidget {
  GroceryTile({super.key, required this.groceryItem, this.onComplete})
      : textDecoration = groceryItem.isComplete
            ? TextDecoration.lineThrough
            : TextDecoration.none;

  final GroceryItem groceryItem;
  final void Function(bool?)? onComplete;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 80,
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
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(decoration: textDecoration),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  DateFormat('MMMM dd h:mm a').format(groceryItem.date),
                  style: TextStyle(decoration: textDecoration),
                ),
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
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 20, decoration: textDecoration),
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
        return Text('low',
            style: TextStyle(
                fontWeight: FontWeight.w200, decoration: textDecoration));
      case Importance.medium:
        return Text('medium',
            style: TextStyle(
                fontWeight: FontWeight.w600, decoration: textDecoration));
      case Importance.high:
        return Text('high',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.red,
                decoration: textDecoration));
      default:
        throw Exception('There is no such importance value');
    }
  }
}
