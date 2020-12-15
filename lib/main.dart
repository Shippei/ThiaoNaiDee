import 'package:ThiaoNaiDee/pages/fast.dart';
import 'package:ThiaoNaiDee/pages/faverite.dart';
import 'package:ThiaoNaiDee/pages/forgot.dart';
import 'package:ThiaoNaiDee/pages/home.dart';
import 'package:ThiaoNaiDee/pages/login.dart';
import 'package:ThiaoNaiDee/pages/make.dart';
import 'package:ThiaoNaiDee/pages/register.dart';
import 'package:ThiaoNaiDee/pages/social.dart';
import 'package:ThiaoNaiDee/pages/trip.dart';
import 'package:ThiaoNaiDee/pages/user.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      title: 'ThiaoNaiDee',
      routes: {
        '/home-page': (context) => HomePage(),
        '/register-page': (context) => RegisterPage(),
        '/forgot-page': (context) => ForgotPage(),
        '/make-page': (context) => MakePage(),
        '/social-page': (context) => SocialPage(),
        '/trip-page': (context) => TripPage(),
        '/user-page': (context) => UserPage(),
        '/faverite-page': (context) => FaveritePage(),
        '/login-page': (context) => LoginPage(),
        '/fast-page': (context) => FastPage(),
      },
    );
  }
}
