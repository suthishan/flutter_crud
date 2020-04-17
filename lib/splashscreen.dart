import 'package:flutter/material.dart';
import 'package:flutter_crud/dashboard.dart';
import 'package:flutter_crud/loginpage.dart';
import 'package:flutter_crud/services/crud.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  crudMedthods crudObj = new crudMedthods();
  final globalKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    new Future.delayed(const Duration(seconds: 5), _handleTapEvent);
    return Scaffold(
       key: globalKey,
      body: _splashContainer(),
    );
  }

  Widget _splashContainer() {
    return Container(      
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(top: 20.0),
              child: new Text("Welcome to Crud Sample",
                style: new TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0),),
            ),
            new Container(
              margin: EdgeInsets.only(top: 5.0),
              child: new Text("(by Suthishan)",
                style: new TextStyle(
                    color: Colors.blue,
                    fontSize: 14.0),),
            )
          ],
        ),
        
      ),
      
    );
  }

  void _handleTapEvent() async {


    if (this.mounted) {
      setState(() {
        if(crudObj.isLoggedIn() != null && crudObj.isLoggedIn()){
          Navigator.pushReplacement(
            context,
            new MaterialPageRoute(builder: (context) => new DashboardPage()),
          );
        }else{
          Navigator.pushReplacement(
            context,
            new MaterialPageRoute(builder: (context) => new LoginPage()),
            
          );
        }
          
      });
    }
  }
}