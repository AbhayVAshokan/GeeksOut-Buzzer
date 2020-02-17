import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

import './widgets/button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
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
  String teamName;
  final rules = [
    "1. Do not switch off your mobile data during the round. This automatically disconnects you from the game.",
    "2. Do not switch between apps or get instant disqualified message.",
    "3. In case of any malpractice, the decision of the organizers will be final.",
  ];
  final teamNameController = TextEditingController();

  void _setTeamName(teamNameController, teamName, BuildContext context) {
    teamName = teamNameController.text;

    if (teamName.isNotEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return Button(teamName, _showBottomNavigation);
        }),
      );
    } else {
      Toast.show("Enter Team Name", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    }
  }

  void _showBottomNavigation(context) {
    showModalBottomSheet(
      backgroundColor: Colors.black38,
        context: context,
        builder: (_) {
          return Container(
            color: Colors.black26,
            padding: EdgeInsets.all(1),
            child: Card(
              color: Colors.black12,
              elevation: 10,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      "RULES",
                      style: GoogleFonts.raleway(
                        fontSize: 40,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ...rules.map((rule) {
                      return Column(
                        children: <Widget>[
                          Text(
                            rule,
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    }).toList()
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/me_and_the_boys.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.75,
            color: Color.fromRGBO(200, 200, 200, 0.9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'ENTER YOUR TEAM NAME GEEK',
                  style: GoogleFonts.lato(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextField(
                    style: GoogleFonts.lato(
                      fontSize: 22,
                      color: Color.fromRGBO(50, 50, 50, 0.75),
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(hintText: "Titanic Swim Team"),
                    controller: teamNameController),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: RaisedButton(
                      color: Colors.blueAccent,
                      child: Align(
                        child: Text(
                          "LET'S ROCK",
                          style: GoogleFonts.raleway(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onPressed: () {
                        _setTeamName(teamNameController, teamName, context);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
