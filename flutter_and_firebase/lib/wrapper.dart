import 'package:flutter/material.dart';
import 'package:flutter_and_firebase/home/home.dart';
import 'package:flutter_and_firebase/authenticate/authenticate.dart';
import 'package:flutter_and_firebase/models/user.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //return either home or authenticate page
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
