import 'package:flutter/material.dart';
import '../components/empty_grocery_screen.dart';
import '../components/grocery_item_screen.dart';
import '../components/grocery_list_screen.dart';
import '../fooderlich_theme.dart';
import '../models/grocery_item.dart';
import '../models/grocery_manager.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: buildGroceryScreen(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final manager = Provider.of<GroceryManager>(context, listen: false);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Theme(
                      data: FooderlichTheme.dark(),
                      child: GroceryItemScreen(
                        onCreate: (GroceryItem groceryItem) {
                          manager.addItem(groceryItem);
                          Navigator.of(context).pop();
                        },
                        onUpdate: (GroceryItem groceryItem) {},
                      ),
                    )));
          },
          child: const Icon(Icons.add),
        ));
  }

  Widget buildGroceryScreen() {
    return Consumer<GroceryManager>(builder: (context, groceryManager, child) {
      if (groceryManager.groceryItems.isNotEmpty) {
        return const GroceryListScreen();
      } else {
        return const EmptyGroceryScreen();
      }
    });
  }
}
