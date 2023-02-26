import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/grocery_manager.dart';
import 'grocery_tile.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groceryManager = Provider.of<GroceryManager>(context);

    return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return GroceryTile(
            groceryItem: groceryManager.groceryItems[index],
            onComplete: (checked) {
              groceryManager.toggleItemStatus(index, checked ?? false);
            },
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 8,
          );
        },
        itemCount: groceryManager.groceryItems.length);
  }
}
