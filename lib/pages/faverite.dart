import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThiaoNaiDee/pages/MyBottomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ThiaoNaiDee/pages/authentication.dart';

class FaveritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FaveriteState();
  }
}

class _FaveriteState extends State<FaveritePage> {
  //String email = 'a@mail.com';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            )),
            title: Text('สถานที่โปรด'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.cyan[200],
            centerTitle: true,
          )),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('User')
            .doc('a@mail.com')
            .collection('faverite')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data.docs.map((document) {
              return Container(
                child: Center(child: Text(document['name'])),
              );
            }).toList(),
          );
        },
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
