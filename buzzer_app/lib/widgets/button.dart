import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatefulWidget {
  final teamName;
  final showBottomNavigation;

  Button(this.teamName, this.showBottomNavigation);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with WidgetsBindingObserver {
  final DatabaseReference database = FirebaseDatabase.instance.reference();
  int disQualifiedState = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _disqualifyCandidate();
    }
  }

  void _disqualifyCandidate() {
    setState(() {
      disQualifiedState = 1;
    });

    database.child(widget.teamName).set({
      'time': "Disqualified",
    });
  }

  void playSound() {
    AudioCache cache = new AudioCache();
    cache.play('lib/assets/Buzzer_sound.mp3');
  }

  sendData(String teamName) {
    playSound();
    database.child(teamName).set({
      'time': DateTime.now().toString(),
    });
  }

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
          widget.teamName,
          overflow: TextOverflow.fade,
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.help),
              onPressed: () => widget.showBottomNavigation(context)),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: WillPopScope(
            child: Center(
              child: disQualifiedState == 0
                  ? RaisedButton(
                      shape: CircleBorder(),
                      color: Color.fromRGBO(128, 0, 0, 1),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.95,
                      ),
                      onPressed: () {
                        sendData(widget.teamName);
                      },
                    )
                  : Center(
                      child: Text(
                      'DISQUALIFIED',
                      style: GoogleFonts.raleway(
                          fontSize: 30, color: Colors.white),
                    )),
            ),
            onWillPop: _onBackPressed),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.question_answer),
        onPressed: () => widget.showBottomNavigation(context),
      ),
    );
  }
}
