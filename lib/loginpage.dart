import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  final globalkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Scaffold(
      appBar: AppBar(
      title: Text('Login')),
      body: new Container(
        child: Column(
        children: <Widget>[_loginContainer()]),
      ),
      ),
    );
  }

  Widget _loginContainer(){
    return new Container(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: 'Enter email'),
            onChanged: (value) {
              this.email = value;
            },
          ),
          SizedBox(height: 10.0),
          TextField(
            decoration: InputDecoration(hintText: 'Enter password'),
            onChanged: (value) {
              this.password = value;
            },
            obscureText: true,
          ),
          SizedBox(height: 10.0),
          RaisedButton(
              onPressed: () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: this.email, password: this.password)
                    .then((signedInUser) {
                  Navigator.of(context).pushReplacementNamed('/homepage');
                }).catchError((e) {
                  print(e);
                });
              },
              textColor: Colors.white,
              child: Text('Login'),
              color: Colors.blue)
        ],
      ),
    );
  }


}
