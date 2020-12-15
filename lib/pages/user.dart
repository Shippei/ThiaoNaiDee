import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(50),
                )),
            title: Text('จัดการบัญชี'),
            backgroundColor: Colors.cyan[300],
            centerTitle: true,
          )),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(100),
              child: Image.asset(
                'images/photo.png',
                height: 80,
                width: 80,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('E-mail :'),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('ชื่อ :'),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('เบอร์โทรศัพท์  :'),
            ),Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OutlineButton(
                    child: Text('แก้ไขข้อมูล'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login-page');
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
