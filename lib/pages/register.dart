import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ลงทะเบียน'),
        backgroundColor: Colors.cyan[200],
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: 'บัญชีผู้ใช้'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: 'รหัสผ่าน'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: 'ชื่อ'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: 'นามสกุล'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: 'เบอร์โทรศัพท์'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 60, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  OutlineButton(
                    child: Text('ยืนยัน'),
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
