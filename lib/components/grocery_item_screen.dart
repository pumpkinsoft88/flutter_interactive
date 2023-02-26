// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../fooderlich_theme.dart';
import '../models/models.dart';
import 'grocery_tile.dart';

class GroceryItemScreen extends StatefulWidget {
  // 1
  final Function(GroceryItem) onCreate;
  // 2
  final Function(GroceryItem) onUpdate;
  // 3
  final GroceryItem? originalItem;
  // 4
  final bool isUpdating;

  const GroceryItemScreen({
    super.key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  }) : isUpdating = (originalItem != null);

  @override
  GroceryItemScreenState createState() => GroceryItemScreenState();
}

class GroceryItemScreenState extends State<GroceryItemScreen> {
  // TODO: Add grocery item screen state properties
  String name = '';
  Importance importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  final _nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final originalItem = widget.originalItem;
    if (originalItem != null) {
      name = originalItem.name;
      importance = originalItem.importance;
      _dueDate = originalItem.date;
      _timeOfDay = TimeOfDay.fromDateTime(originalItem.date);
      _currentColor = originalItem.color;
      _currentSliderValue = originalItem.quantity;
      _nameController.text = originalItem.name;
    }

    _nameController.addListener(() {
      name = _nameController.text;
      print(name);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add GroceryItemScreen Scaffold
    return Theme(
      data: FooderlichTheme.dark(),
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    final groceryItem = GroceryItem(
                        id: widget.originalItem?.id ?? const Uuid().v1(),
                        name: _nameController.text,
                        importance: importance,
                        color: _currentColor,
                        quantity: _currentSliderValue.toInt(),
                        date: DateTime(_dueDate.year, _dueDate.month,
                            _dueDate.day, _timeOfDay.hour, _timeOfDay.minute));
                    if (widget.isUpdating) {
                      widget.onUpdate(groceryItem);
                    } else {
                      widget.onCreate(groceryItem);
                    }
                  },
                  icon: const Icon(Icons.check))
            ],
            elevation: 0.0,
            title: Text(
              'Grocery Item',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontFamily: GoogleFonts.lemon().fontFamily,
                  fontWeight: FontWeight.w200),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              buildNameField(),
              buildImportanceField(),
              buildDateField(),
              buildTimeField(),
              buildColorPicker(),
              buildQuantityField(),
              GroceryTile(
                groceryItem: GroceryItem(
                  id: 'asdf',
                  name: name,
                  importance: importance,
                  color: _currentColor,
                  date: DateTime(_dueDate.year, _dueDate.month, _dueDate.day,
                      _timeOfDay.hour, _timeOfDay.minute),
                  quantity: _currentSliderValue.toInt(),
                ),
              )
            ],
          )),
    );
  }

  // TODO: Add buildNameField()
  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Item Name', style: Theme.of(context).textTheme.headline2),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
              hintText: 'E.g. Apples, Banana, 1 Bag of Salt',
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _currentColor))),
        )
      ],
    );
  }

  // TODO: Add buildImportanceField()
  Widget buildImportanceField() {
    const textStyle = TextStyle(color: Colors.white);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Importance', style: Theme.of(context).textTheme.headline2),
        Wrap(
          spacing: 10,
          children: [
            ChoiceChip(
                onSelected: (selected) {
                  setState(() {
                    importance = Importance.low;
                  });
                },
                selectedColor: Colors.black,
                label: const Text(
                  'low',
                  style: textStyle,
                ),
                selected: importance == Importance.low),
            ChoiceChip(
                onSelected: (selected) {
                  setState(() {
                    importance = Importance.medium;
                  });
                },
                selectedColor: Colors.black,
                label: const Text(
                  'medium',
                  style: textStyle,
                ),
                selected: importance == Importance.medium),
            ChoiceChip(
                onSelected: (selected) {
                  setState(() {
                    importance = Importance.high;
                  });
                },
                selectedColor: Colors.black,
                label: const Text(
                  'high',
                  style: textStyle,
                ),
                selected: importance == Importance.high),
          ],
        )
      ],
    );
  }

  // TODO: ADD buildDateField()
  Widget buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Date', style: Theme.of(context).textTheme.headline2),
            TextButton(
                onPressed: () async {
                  final currentDate = DateTime.now();
                  final dateSelected = await showDatePicker(
                      context: context,
                      initialDate: currentDate,
                      firstDate: currentDate,
                      lastDate: DateTime(currentDate.year + 5));
                  if (dateSelected != null) {
                    _dueDate = dateSelected;
                    setState(() {});
                  }
                },
                child: Text(
                  'select',
                  style: TextStyle(color: _currentColor),
                ))
          ],
        ),
        Text(DateFormat('yyyy-MM-dd').format(_dueDate))
      ],
    );
  }

  // TODO: Add buildTimeField()
  Widget buildTimeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Time of day', style: Theme.of(context).textTheme.headline2),
            TextButton(
                onPressed: () async {
                  final timeSelected = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (timeSelected != null) {
                    _timeOfDay = timeSelected;
                    setState(() {});
                  }
                },
                child: Text(
                  'select',
                  style: TextStyle(color: _currentColor),
                ))
          ],
        ),
        Text(_timeOfDay.format(context))
      ],
    );
  }

  // TODO: Add buildColorPicker()
  Widget buildColorPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 10,
          height: 50,
          color: _currentColor,
        ),
        const SizedBox(width: 8),
        Expanded(
            child: Text('Color', style: Theme.of(context).textTheme.headline2)),
        TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: BlockPicker(
                          pickerColor: Colors.white,
                          onColorChanged: (color) {
                            _currentColor = color;
                            setState(() {});
                          }),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('save'))
                      ],
                    );
                  });
            },
            child: Text(
              'select',
              style: TextStyle(color: _currentColor),
            ))
      ],
    );
  }

  // TODO: Add buildQuantityField()
  Widget buildQuantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Quantity', style: Theme.of(context).textTheme.headline2),
            const SizedBox(
              width: 10,
            ),
            Text(_currentSliderValue.toInt().toString(),
                style: Theme.of(context).textTheme.bodyText1)
          ],
        ),
        Slider(
            min: 0.0,
            max: 100.0,
            activeColor: _currentColor,
            inactiveColor: _currentColor.withOpacity(0.5),
            divisions: 100,
            label: _currentSliderValue.toInt().toString(),
            value: _currentSliderValue.toDouble(),
            onChanged: (double quantity) {
              _currentSliderValue = quantity.toInt();
              setState(() {});
            })
      ],
    );
  }
}
