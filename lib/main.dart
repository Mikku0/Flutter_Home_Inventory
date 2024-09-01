import 'package:flutter/material.dart';

void main() {
  runApp(HomeInventoryApp());
}

class HomeInventoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Inventory',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SUSE',
      ),
      home: InventoryPage(),
    );
  }
}

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final List<Item> _items = [];
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  String _selectedCategory = 'Kitchen 🍽️';

  List<String> _categories = [
    'Kitchen 🍽️',
    'Bedroom 🛋️',
    'Living Room 🛏️',
    'Bathroom 🛁'
  ];

  void _addItem(String name, String category) {
    setState(() {
      _items.add(Item(name: name, category: category));
      _itemController.clear();
    });
  }

  void _addCategory() {
    String newCategory = _categoryController.text.trim();
    if (newCategory.isNotEmpty && !_categories.contains(newCategory)) {
      setState(() {
        _categories.add(newCategory);
        _selectedCategory = newCategory;
        _categoryController.clear();
      });
      Navigator.pop(context);
    }
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _toggleItemStatus(int index, bool? value) {
    setState(() {
      _items[index].isOwned = value ?? false;
    });
  }

  void _showAddCategorySheet() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    labelText: 'Category name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addCategory,
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Inventory'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _itemController,
                    decoration: InputDecoration(
                      labelText: 'Add Item',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      if (newValue == 'Add Category') {
                        _showAddCategorySheet();
                      } else {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      }
                    }
                  },
                  items: [
                    ..._categories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    DropdownMenuItem<String>(
                      value: 'Add Category',
                      child: Text('[Add Category]'),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (_itemController.text.isNotEmpty) {
                      _addItem(_itemController.text, _selectedCategory);
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _items[index].name,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              '(${_items[index].category})',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Checkbox(
                        value: _items[index].isOwned,
                        onChanged: (value) => _toggleItemStatus(index, value),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _removeItem(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  final String name;
  final String category;
  bool isOwned;

  Item({required this.name, required this.category, this.isOwned = false});
}
