import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThiaoNaiDee/pages/MyBottomNavBar.dart';
import 'package:ThiaoNaiDee/pages/authentication.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserState();
  }
}

class _UserState extends State<UserPage> {
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
            title: Text('จัดการบัญชี'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.cyan[200],
            centerTitle: true,
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlineButton(
              onPressed: () {
                Navigator.pushNamed(context, '/edit-page');
              },
              child: Text("แก้ไขข้อมูล"),
            ),
            OutlineButton(
              onPressed: () {
                context.read<Authentication>().signOut();
                Navigator.pushNamed(context, '/aut-page');
              },
              child: Text("ออกจากระบบ"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
