import 'package:flutter/material.dart';
import 'package:flutter_and_firebase/home/home.dart';
import 'package:flutter_and_firebase/services/auth.dart';
import 'package:flutter_and_firebase/shared/constants.dart';
import 'package:flutter_and_firebase/shared/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService ();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
   //Text field state
  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Sign In',
          style: TextStyle (
            color: Colors.green,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            label: Text (
              'Register',
              style: TextStyle (
                color: Colors.green,
              ),
            ),
            icon: Icon(
              Icons.account_circle_sharp,
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Form (
          key: _formKey,
          child: Column (
            children: <Widget>[
              SizedBox (height: 10,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter Email Address' : null,
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.length < 6 ? 'Enter at least 6 characters' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox (height: 20,),
              RaisedButton (
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmail(email, password);
                    if (result == null) {
                      setState(() {
                        loading = false;
                        error = 'No credentials found';
                      });
                    }
                  }
                },
                child: Text('Sign In'),
              ),
              SizedBox (height: 10,),
              Text (error,
                style: TextStyle (
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
