import 'package:expried_item_app/pages/add_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpriedMain extends StatefulWidget {
  const ExpriedMain({Key? key}) : super(key: key);

  @override
  State<ExpriedMain> createState() => _ExpriedMainState();
}

class _ExpriedMainState extends State<ExpriedMain> {
  String dropdownValue = 'all';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: DropdownButton(
              value: dropdownValue,
              icon: const Icon(Icons.keyboard_arrow_down_outlined),
              elevation: 0,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              dropdownColor: Colors.indigo,
              underline: const SizedBox(
                height: 0,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: ['all', 'newest', 'oldest', 'food', 'etc']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList()),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () => _checkAndDelete,
              icon: const Icon(Icons.check, color: Colors.white))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _checkAndDelete() {

  }
  void _addNewItem(){
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddPage()));
  }
}
