import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThiaoNaiDee/pages/authentication.dart';
import 'package:provider/provider.dart';

class EditproPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditproState();
  }
}

class _EditproState extends State<EditproPage> {
  //TextEditingController emailController = TextEditingController();
  TextEditingController name1Controller = TextEditingController();
  TextEditingController name2Controller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล'),
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
                decoration: InputDecoration(labelText: 'ชื่อ'),
                controller: name1Controller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: 'นามสกุล'),
                controller: name2Controller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: 'เบอร์โทร'),
                controller: phoneController,
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
                      context.read<Authentication>().editproflie(
                            //email: emailController.text.trim(),
                            email: 'a@mail.com',
                            name1: name1Controller.text.trim(),
                            name2: name2Controller.text.trim(),
                            phone1: phoneController.text.trim(),
                          );
                      Navigator.pushNamed(context, '/user-page');
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
