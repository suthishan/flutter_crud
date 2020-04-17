import 'package:flutter/material.dart';
import 'package:flutter_crud/dashboard.dart';
import 'package:flutter_crud/loginpage.dart';
import 'package:flutter_crud/services/crud.dart';
import 'package:flutter_crud/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
      routes:<String, WidgetBuilder> {
        '/homepage' : (BuildContext context) => DashboardPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  crudMedthods crudObj = new crudMedthods();

  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Crud sample'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: new Center(
        child: SplashScreen(),
      ),
    );
  }
}
