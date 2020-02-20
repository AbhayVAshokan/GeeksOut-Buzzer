import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseReference database = FirebaseDatabase.instance.reference();
  var teamData, fastestIndex = -1;
  var fastestTime = DateTime(2000, 1, 1, 1, 1, 1, 1, 1);
  List<String> teamName = [];
  List<DateTime> teamTime = [];

  void deleteData(teamName, teamTime) {
    database.child('pressedTeams').remove();
    setState(() {
      teamName.clear();
      teamTime.clear();
      fastestIndex = -1;
      fastestTime = DateTime(2000, 1, 1, 1, 1, 1, 1, 1);
    });
  }

  void getData(teamName, teamTime) {
    database.once().then((DataSnapshot snapshot) {
      print(
          'Data : ${snapshot.value} \n ${snapshot.value['pressedTeams'].length}');
      setState(() {
        teamName.clear();
        teamTime.clear();

        teamData = snapshot.value['pressedTeams'];
        teamData.forEach((name, date) {
          teamName.add(name);
          if (date['time'].compareTo("Disqualified") == 0) {
            teamTime.add(DateTime.now().add(Duration(days: 5)));
          } else {
            teamTime.add(DateTime.parse(date['time']));
          }
        });

        for (int i = 0;
            i < teamData.length &&
                teamTime[i].isBefore(DateTime.now().add(Duration(days: 2)));
            i++) {
          print('index: $i');
          if (fastestIndex == -1) {
            setState(() {
              fastestIndex = i;
              fastestTime = teamTime[i];
            });
          } else if (teamTime[i].isBefore(teamTime[fastestIndex])) {
            setState(() {
              fastestIndex = i;
              fastestTime = teamTime[i];
            });
          }
        }
      });
      print('updated list: $teamName, $teamTime, $fastestIndex');
    });
    print('pressed refreshed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/deadpool.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            width: MediaQuery.of(context).size.width * 0.9,
            color: Color.fromRGBO(10, 10, 10, 30),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          ...teamName.map((name) {
                            return Column(
                              children: <Widget>[
                                Card(
                                  color: Color.fromRGBO(252, 190, 3, 0.5),
                                  child: Container(
                                    height: 20,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                      name,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.raleway(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            );
                          }).toList()
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ...teamTime.map((time) {
                            return Column(
                              children: <Widget>[
                                time.isAfter(
                                        DateTime.now().add(Duration(days: 2)))
                                    ? Card(
                                        color: Color.fromRGBO(255, 0, 0, 0.3),
                                        child: Container(
                                          height: 20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          margin: EdgeInsets.all(10),
                                          child: Center(
                                            child: Text(
                                              "DISQUALIFIED",
                                              style: GoogleFonts.lato(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : time.isAtSameMomentAs(fastestTime)
                                        ? Card(
                                            color:
                                                Color.fromRGBO(26, 158, 0, 0.3),
                                            child: Container(
                                              height: 20,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              margin: EdgeInsets.all(10),
                                              child: Center(
                                                child: Text(
                                                  DateFormat("h : m : s.ms")
                                                      .format(time),
                                                  style: GoogleFonts.lato(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Card(
                                            child: Container(
                                              height: 20,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              margin: EdgeInsets.all(10),
                                              child: Center(
                                                child: Text(
                                                  DateFormat("h : m : s.ms")
                                                      .format(time),
                                                  style: GoogleFonts.lato(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                SizedBox(height: 20),
                              ],
                            );
                          }).toList()
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 120,
                        child: RaisedButton(
                            color: Colors.green,
                            child: Text(
                              'REFRESH',
                              style: GoogleFonts.lato(fontSize: 20),
                            ),
                            onPressed: () => getData(teamName, teamTime)),
                      ),
                      Container(
                        width: 120,
                        child: RaisedButton(
                          color: Colors.red,
                          child: Text('RESET',
                              style: GoogleFonts.lato(fontSize: 20)),
                          onPressed: () => deleteData(teamName, teamTime),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
