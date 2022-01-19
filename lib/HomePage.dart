import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fb = FirebaseDatabase.instance;
  final myController = TextEditingController();
  var name = "Name";
  var n = '';
  List<List<String>> array = [];

  var retrievedName;
  @override
  Widget build(BuildContext context) {
    final ref = fb.reference();
    final tictactoeFire = fb.reference().child("/array");
    final nameFirebase = fb.reference().child("/${name}");

    tictactoeFire.onChildAdded.listen((event) {
      var value = event.snapshot.value;
      print(value);
    });

    nameFirebase.onChildAdded.listen((event) {
      var value = event.snapshot.value;
      print(value);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Demo"),
      ),
      body: Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(name),
                  SizedBox(width: 20),
                  Expanded(child: TextField(controller: myController)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  ref.child(name).set(myController.text);
                },
                child: Text("Submit"),
              ),
              ElevatedButton(
                onPressed: () {
                  Map<String, dynamic> newText = {};
                  newText["${name}"] = myController.text;
                  ref.update(newText);
                },
                child: Text("Update",)),
            ],
          ))
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

}
