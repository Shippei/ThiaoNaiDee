import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  String message;
  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Image.asset(
                'images/logo.jpg',
                height: 200,
                width: 200,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 10, 60, 0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: 'บัญชีผู้ใช้'),
                  controller: _usernameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
                child: TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'รหัสผ่าน'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 60, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    OutlineButton(
                      child: Text('เข้าสู่ระบบ'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/home-page');
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text('ลงทะเบียน'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/register-page');
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text('ลืมรหัสผ่าน'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot-page');
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
