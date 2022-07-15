import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expried_item_app/components/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _spaceControll = TextEditingController();
  late DateTime selectedDate;
  String dropdownValue = 'beauty';

  @override
  void dispose() {
    _spaceControll.dispose();
    super.dispose();
  }

  @override
  void initState() {
    selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add item'),
        backgroundColor: Colors.indigo,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: namespace,
              ),
              Text(
                'item name',
                style: Theme.of(context).textTheme.headline4,
              ),
              TextFormField(
                controller: _spaceControll,
                maxLength: 20,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                    hintText: 'write your item',
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 6,
                    )),
              ),
              const SizedBox(
                height: namespace,
              ),
              Row(
                children: [
                  Text(
                    'item term',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: ElevatedButton(
                      child: const Text('Date Check'),
                      onPressed: () {
                        _showDatePicker();
                      },
                    ),
                  ),
                ],
              ),
              Text('유효기간 : ${DateFormat('yyyy-MM-dd').format(selectedDate)} 까지',
                  style: Theme.of(context).textTheme.subtitle1),
              Text('select category',
                  style: Theme.of(context).textTheme.headline6),
              DropdownButton(
                  value: dropdownValue,
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  elevation: 0,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  dropdownColor: Colors.white,
                  underline: const SizedBox(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: ['beauty', 'food', 'etc']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: _createDoc,
                    child: const Text('Add'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) {
                if (value != null && value != selectedDate) {
                  setState(() {
                    selectedDate = value;
                  });
                }
              },
              initialDateTime: DateTime.now(),
              minimumYear: 2022,
              maximumYear: 2042,
            ),
          );
        });
  }

  void _createDoc() async {
    final User? user = FirebaseAuth.instance.currentUser;

    CollectionReference users =
        FirebaseFirestore.instance.collection(user!.email.toString());
    users.doc(_spaceControll.text).set({
      'name': _spaceControll.text,
      'category': dropdownValue,
      'itemTerm': DateFormat('yyyy-MM-dd').format(selectedDate),
      'addItem': DateFormat('yyyy-MM-dd').format(DateTime.now())
    });
  }
}
