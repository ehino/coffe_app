import 'package:flutter/material.dart';
import 'package:flutter_and_firebase/home/home.dart';
import 'package:flutter_and_firebase/services/auth.dart';
import 'package:flutter_and_firebase/shared/constants.dart';
import 'package:flutter_and_firebase/shared/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register ({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

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
            'Sign Up',
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
              'Log In',
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
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter at least 6 words as password' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox (height: 20,),
              RaisedButton (
                child: Text('Sign Up'),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmail(email, password);
                    if (result == null) {
                      setState(() {
                        loading = false;
                        error = 'Please use valid credentials';
                      });
                    }
                  }
                }
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
