import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ThiaoNaiDee/pages/authentication.dart';
import 'package:provider/provider.dart';

class MakePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MakeState();
  }
}

class _MakeState extends State<MakePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มแผน'),
        backgroundColor: Colors.cyan[200],
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: 'ชื่อแผน'),
                controller: nameController,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 20, 10, 30),
                  child: SizedBox.fromSize(
                    size: Size(56, 56), // button width and height
                    child: ClipOval(
                      child: Material(
                        color: Colors.cyan[200], // button color
                        child: InkWell(
                          splashColor: Colors.yellow[200], // splash color
                          onTap: () {}, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.add), // icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text('ค้นหาด้วยชื่อ'),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 10, 30),
                  child: SizedBox.fromSize(
                    size: Size(56, 56), // button width and height
                    child: ClipOval(
                      child: Material(
                        color: Colors.cyan[200], // button color
                        child: InkWell(
                          splashColor: Colors.yellow[200], // splash color
                          onTap: () {}, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.add), // icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Text('เพิ่มจากรายการโปรด'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: 'วันเดินทาง'),
                controller: timeController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
              child: Text('รายละเอียด'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 60, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  OutlineButton(
                    child: Text('ตกลง'),
                    onPressed: () {
                      context.read<Authentication>().addtrip(
                            email: 'a@mail.com',
                            name1: nameController.text.trim(),
                            time: timeController.text.trim(),
                          );
                      Navigator.pushNamed(context, '/home-page');
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
