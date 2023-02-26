import 'package:flutter/material.dart';
import 'grocery_item_screen.dart';
import 'package:provider/provider.dart';
import '../fooderlich_theme.dart';
import 'grocery_tile.dart';
import '../models/models.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groceryManager = Provider.of<GroceryManager>(context);

    return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(groceryManager.groceryItems[index].id),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              groceryManager.deleteItem(index);
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 36,
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Theme(
                              data: FooderlichTheme.dark(),
                              child: GroceryItemScreen(
                                onCreate: (GroceryItem groceryItem) {},
                                onUpdate: (GroceryItem groceryItem) {
                                  groceryManager.updateItem(groceryItem, index);
                                  Navigator.pop(context);
                                },
                                originalItem:
                                    groceryManager.groceryItems[index],
                              ),
                            )));
              },
              child: GroceryTile(
                groceryItem: groceryManager.groceryItems[index],
                onComplete: (checked) {
                  groceryManager.toggleItemStatus(index, checked ?? false);
                },
              ),
            ),
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
