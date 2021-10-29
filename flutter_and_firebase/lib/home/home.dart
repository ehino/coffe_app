import 'package:flutter/material.dart';
import 'package:flutter_and_firebase/home/settings_form.dart';
import 'package:flutter_and_firebase/models/brew.dart';
import 'package:flutter_and_firebase/models/user.dart';
import 'package:flutter_and_firebase/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_and_firebase/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _signOutService = AuthService();
  
  @override
  Widget build(BuildContext context) {

    void _showUserSettings () {
      showModalBottomSheet(context: context, builder: (context) {
        return Container (
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: SettingsForm(),
        );

      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brewSnapshot,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text ('Home'),
          actions: <Widget> [
            FlatButton.icon(
                onPressed: () async{
                  await _signOutService.signOut();
                  Fluttertoast.showToast(
                      msg: 'Logged  Out');
                },
                icon: Icon(Icons.person,
                color:Colors.white,
                ),
                label: Text('Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
                ),
            ),
            FlatButton.icon (
              icon: Icon(Icons.settings),
              label: Text('Settings',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                return _showUserSettings();
              },
            ),
          ],
        ),
        body: BrewList(

        ),
      ),
    );
  }
}

