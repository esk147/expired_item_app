import 'package:flutter/material.dart';

class ExpriedMain extends StatefulWidget {
  const ExpriedMain({Key? key}) : super(key: key);

  @override
  State<ExpriedMain> createState() => _ExpriedMainState();
}

class _ExpriedMainState extends State<ExpriedMain> {
  String dropdownValue = 'All';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Center(
        child: DropdownButton(
            value: dropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            elevation: 16,
            style: const TextStyle(color: Colors.white), dropdownColor: Colors.black,
            underline: const SizedBox(
              height: 0,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: ['All', 'newest', 'oldest', 'food', 'etc']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList()),
      ),
      backgroundColor: Colors.indigo,
    ));
  }
}
