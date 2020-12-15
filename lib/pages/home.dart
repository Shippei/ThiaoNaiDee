import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            )),
            title: Text('หน้าหลัก'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.cyan[200],
            centerTitle: true,
          )),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: RaisedButton(
                        elevation: 0.0,
                        color: Colors.redAccent[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.only(
                            top: 30, bottom: 30, right: 50, left: 10),
                        onPressed: () {
                          Navigator.pushNamed(context, '/faverite-page');
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 35),
                              child: Icon(
                                Icons.map,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text(
                                  "แผนที่  ",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: RaisedButton(
                        elevation: 0.0,
                        color: Colors.yellow[200],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.only(
                            top: 30, bottom: 30, right: 20, left: 10),
                        onPressed: () {
                          Navigator.pushNamed(context, '/faverite-page');
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.black,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "สถานที่โปรด  ",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: RaisedButton(
                        elevation: 0.0,
                        color: Colors.greenAccent[200],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.only(
                            top: 30, bottom: 30, right: 5, left: 10),
                        onPressed: () {
                          Navigator.pushNamed(context, '/trip-page');
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.book,
                              color: Colors.black,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "แผนการเดินทาง  ",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: RaisedButton(
                        elevation: 0.0,
                        color: Colors.cyan[200],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.only(
                            top: 30, bottom: 30, right: 40, left: 10),
                        onPressed: () {
                          Navigator.pushNamed(context, '/social-page');
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Icon(
                                Icons.share,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 40),
                                child: Text(
                                  "แชร์ทริป  ",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: RaisedButton(
                        elevation: 0.0,
                        color: Colors.lightGreenAccent[200],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.only(
                            top: 30, bottom: 30, right: 30, left: 10),
                        onPressed: () {
                          Navigator.pushNamed(context, '/user-page');
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "ข้อมูลผู้ใช้  ",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: RaisedButton(
                        elevation: 0.0,
                        color: Colors.indigoAccent[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.only(
                            top: 30, bottom: 30, right: 20, left: 10),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login-page');
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.black,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "ออกจากระบบ  ",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ))
                          ],
                        ),
                      ),
                    ),
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
