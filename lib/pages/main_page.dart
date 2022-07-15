import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expried_item_app/pages/add_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpriedMain extends StatefulWidget {
  const ExpriedMain({Key? key}) : super(key: key);

  @override
  State<ExpriedMain> createState() => _ExpriedMainState();
}

class _ExpriedMainState extends State<ExpriedMain> {
  String dropdownValue = 'newest';
  String searchString = '';

  static User? loginUser = FirebaseAuth.instance.currentUser;
  final userReference = FirebaseFirestore.instance.collection(loginUser!.email.toString());
  
  final list = [
    'item1',
    'item2',
    'item3',
  ];

  final list2 = [
    'term1',
    'term2',
    'term3',
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchString = value.toLowerCase();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 500,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: userReference.orderBy('itemTerm',descending: true).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(snapshot.hasError) return Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        return const Text('loading..');
                        default:
                        return ListView(
                          children: snapshot.data!.docs.map((DocumentSnapshot document){
                            return Card(
                              elevation: 2,
                              child: InkWell(
                                onLongPress: () {
                                  _showDialog(document);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Text(document['name']),
                                          const Spacer(),
                                          Text(document['itemTerm2'])
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
            // child: ListView.separated(
            //   padding: const EdgeInsets.all(15),
            //   itemCount: list.length,
            //   itemBuilder: (context, index) {
            //     return ExpriedListTile(name: list[index],term: list2[index],);
            //   },
            //   separatorBuilder: (context, index) {
            //     return const Divider(
            //       height: 20,
            //     );
            //   },
            // ),
          )
        ],
      ),
    );
  }

  void _showDialog(DocumentSnapshot doc){

  }

  void _addNewItem() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddPage()));
  }
}

class ExpriedListTile extends StatelessWidget {
  const ExpriedListTile({
    Key? key,
    required this.name,
    required this.term,
  }) : super(key: key);

  final String name;
  final String term;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              name,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              term,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
