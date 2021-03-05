import 'package:ThiaoNaiDee/pages/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThiaoNaiDee/pages/MyBottomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class FaveritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FaveriteState();
  }
}

class _FaveriteState extends State<FaveritePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
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
            .doc(auth.currentUser.email.toString())
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(document['name']),
                                  content:
                                      Text("รายละเอียด : " + document['more']),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('ยืนยันการลบข้อมูล'),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    context
                                                        .read<Authentication>()
                                                        .deletefav(
                                                            email: auth
                                                                .currentUser
                                                                .email
                                                                .toString(),
                                                            name: document[
                                                                'name']);

                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('ตกลง'),
                                                ),
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('ยกเลิก'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Text('ลบข้อมูล'),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('ตกลง'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Column(
                            children: [
                              Text("ชื่อ :" + document['name']),
                              Text("รายละเอียด : " + document['more']),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
