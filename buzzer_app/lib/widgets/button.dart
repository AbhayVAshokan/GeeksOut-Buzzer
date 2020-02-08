import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final teamName;
  final showBottomNavigation;

  Button(this.teamName, this.showBottomNavigation);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GOOD LUCK " + widget.teamName,
          overflow: TextOverflow.fade,
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.help),
              onPressed: () => widget.showBottomNavigation(context)),
        ],
      ),
      body: WillPopScope(
          child: Center(
            child: RaisedButton(
              shape: CircleBorder(),
              color: Colors.red,
              child: Container(
                height: MediaQuery.of(context).size.width * 0.95,
              ),
              onPressed: () {},
            ),
          ),
          onWillPop: _onBackPressed),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.question_answer),
        onPressed: () => widget.showBottomNavigation(context),
      ),
    );
  }
}
