import 'package:expried_item_app/pages/add_page.dart';
import 'package:flutter/material.dart';

class ExpriedMain extends StatefulWidget {
  const ExpriedMain({Key? key}) : super(key: key);

  @override
  State<ExpriedMain> createState() => _ExpriedMainState();
}

class _ExpriedMainState extends State<ExpriedMain> {
  String dropdownValue = 'newest';

  final list = [
    'item1',
    'item2',
    'item3',
  ];
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
              items: ['newest', 'oldest', 'beauty', 'food', 'etc']
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
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ExpriedListTile(name: list[index]);
        },
      ),
    );
  }

  void _checkAndDelete() {}
  void _addNewItem() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddPage()));
  }
}

class ExpriedListTile extends StatelessWidget {
  const ExpriedListTile({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Row(
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text('term box'),
          ),
        ],
      ),
    );
  }
}
