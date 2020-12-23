import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class LoginPage extends StatelessWidget {
  final Color secondaryColor = Color(0xff232c51);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // ignore: unused_field
  String message;

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
              SizedBox(
                height: 30,
              ),
              _buildTextField(
                  nameController, Icons.account_circle, 'บัญชีผู้ใช้', false),
              SizedBox(
                height: 20,
              ),
              _buildTextField(passwordController, Icons.lock, 'รหัสผ่าน', true),
              SizedBox(height: 30),
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
              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                onPressed: _signInWithGoogle,
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.google),
                    SizedBox(width: 10),
                    Text('Sign-in using Google',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTextField(TextEditingController controller, IconData icon,
      String labelText, bool a) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        obscureText: a,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }

  _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    final FirebaseUser user =
        (await firebaseAuth.signInWithCredential(credential)).user;
  }
}
