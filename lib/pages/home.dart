import 'package:ThiaoNaiDee/pages/MyBottomNavBar.dart';
import 'package:ThiaoNaiDee/pages/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
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
            title: Text('แผนเดินทาง'),
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
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('เพิ่มแผน'),
                        content: Text('โปรดเลือกรายการของท่าน'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/make-page');
                            },
                            child: Text('กำหนดเอง'),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/fast-page');
                            },
                            child: Text('จัดแบบด่วน'),
                          ),
                        ],
                      );
                    });
              },
              child: Text("เพิ่มแผน"),
            ),
            // OutlineButton(
            //   onPressed: () {
            //     context.read<Authentication>().subdata(
            //           email: 'a@mail.com',
            //           name1: 'a',
            //         );
            //   },
            //   child: Text("ทดสอบเพิ่มข้อมูล"),
            // ),
            // OutlineButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/search-page');
            //   },
            //   child: Text("ค้นหา"),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
