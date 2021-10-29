import 'package:flutter/material.dart';
import 'package:flutter_and_firebase/models/user.dart';
import 'package:flutter_and_firebase/services/auth.dart';
import 'package:flutter_and_firebase/wrapper.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );

  }
}

