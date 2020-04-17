import 'dart:async';

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_crud/loginpage.dart';

import 'services/crud.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String taskTitle;
  String taskDetails;

  var tasks;

  crudMedthods crudObj = new crudMedthods();

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Task', style: TextStyle(fontSize: 15.0)),
            content: Container(
                height: 125.0,
                width: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Task Title'),
                    onChanged: (value) {
                      this.taskTitle = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Task Details'),
                    onChanged: (value) {
                      this.taskDetails = value;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Add'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  crudObj.addData({
                    'taskTitle': this.taskTitle,
                    'taskDetails': this.taskDetails
                  }).then((result) {
                    dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              )
            ],
          );
        });
  }

  Future<bool> updateDialog(BuildContext context, selectedDoc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Data', style: TextStyle(fontSize: 15.0)),
            content: Container(
              height: 125.0,
              width: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Task Title'),
                    onChanged: (value) {
                      this.taskTitle = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Task Details'),
                    onChanged: (value) {
                      this.taskDetails = value;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Update'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  crudObj.updateData(selectedDoc, {
                    'taskTitle': this.taskTitle,
                    'taskDetails': this.taskDetails
                  }).then((result) {
                    // dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              )
            ],
          );
        });
  }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Task Done', style: TextStyle(fontSize: 15.0)),
            content: Text('Added'),
            actions: <Widget>[
              FlatButton(
                child: Text('Alright'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    crudObj.getData().then((results) {
      setState(() {
        tasks = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                addDialog(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                crudObj.getData().then((results) {
                  setState(() {
                    tasks = results;
                  });
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.supervised_user_circle),
              onPressed: () {
                _onWillPop();
              },
            )
          ],
        ),
        body: Center(
          child: _taskList(),
        ));
  }

  Widget _taskList() {
    if (tasks != null) {
      return StreamBuilder(
        stream: tasks,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: EdgeInsets.all(5.0),
              itemBuilder: (context, i) {
                return new ListTile(
                  title: Text(snapshot.data.documents[i].data['taskTitle']),
                  subtitle: Text(snapshot.data.documents[i].data['taskDetails']),
                  onTap: () {
                    updateDialog(
                        context, snapshot.data.documents[i].documentID);
                  },
                  onLongPress: () {
                    crudObj.deleteData(snapshot.data.documents[i].documentID);
                  },
                );
              },
            );
          } 
        },
      );
    } else {
      return Text('Loading, Please wait..');
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to Logout?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () {
              crudObj.signout();
              Navigator.of(context).pop(true);
              navigateToLogin(context);
            },
            // Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  Future navigateToLogin(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
}
}
