import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowtimePage extends StatefulWidget {
  final String tripname;
  ShowtimePage({Key key, this.tripname}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ShowtimeState();
  }
}

class _ShowtimeState extends State<ShowtimePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
          title: Text(widget.tripname),
          backgroundColor: Colors.cyan[200],
          centerTitle: true,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('User')
            .doc(auth.currentUser.email.toString())
            .collection('trip')
            .doc(widget.tripname)
            .collection('A')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: [
              Column(
                children: [
                  Text(""),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("        "),
                      Text("รายการ"),
                      Text(
                          "                                                      "),
                      OutlineButton(
                        onPressed: () {},
                        child: Text("เพิ่มรายการ"),
                      ),
                      Text("     "),
                    ],
                  ),
                  Text(
                      "----------------------------------------------------------------------------------"),
                  Column(
                    children: snapshot.data.docs.map((document) {
                      return Container(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 24.0),
                              ButtonTheme(
                                minWidth: 200.0,
                                height: 100.0,
                                child: OutlineButton(
                                  borderSide: BorderSide(
                                    color: Colors.cyan[200],
                                    style: BorderStyle.solid,
                                    width: 2,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShowtimePage(
                                            tripname: document['name']),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Text(document['name']),
                                      Text("วันเดินทาง : " +
                                          document['time']
                                              .toDate()
                                              .toIso8601String()
                                              .split('T')
                                              .first),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
