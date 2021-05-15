import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Retrieving extends StatefulWidget{

  @override
  _RetrievingState createState() => _RetrievingState();
}
final firestoreInstance = FirebaseFirestore.instance;
void getDocument() async {
  print("getDocument");

  //assume there is a collection called "users"
  var uid = "nHVYweSvDz5yop3mCy9B"; //the unique user id/document id

  await firestoreInstance.collection("dayinyear").doc(uid).get().then((querySnapshot) {
    print("result");
    print(querySnapshot.data());
  });
}

class _RetrievingState extends State<Retrieving> {
  @override
  void initState() {
    getDocument();
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Demo')),
    body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("dayinyear").snapshots(),
      builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot){
        return ListView.builder(
          itemCount: streamSnapshot.data.docs.length,
          itemBuilder: (context,index){
            DocumentSnapshot item=streamSnapshot.data.docs[index];
            return ListTile(
              title: Text(item['name']),
            );
          },
        );
      },
    ),
  );

  }
}