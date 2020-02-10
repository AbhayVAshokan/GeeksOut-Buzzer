import 'package:flutter/material.dart';
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
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) {
        return Button(teamName, _showBottomNavigation);
      }),
    );
  }

  void _showBottomNavigation(context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            color: Colors.black26,
            child: Card(
              color: Colors.black12,
              elevation: 10,
              child: Text("Hello World"),
            ),
          );
        });
  }

  Future<bool> _enterTeamName() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: Text(
              'ENTER GEEK NAME',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            content: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: "Titanic Swim Team"),
              controller: teamNameController,
            ),
            actions: <Widget>[
              RaisedButton(
                child: Text("Let's Rock"),
                onPressed: () {
                  _setTeamName(teamNameController, teamName, context);
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
          backgroundColor: Colors.black26,
          title: new Text("ENTER TEAM NAME GEEK!"),
          content: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: "Titanic Swim Team",
                labelStyle: TextStyle(
                  color: Colors.white,
                )),
            controller: teamNameController,
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text("Let's Rock"),
              onPressed: () {
                _setTeamName(teamNameController, teamName, context);
              },
            ),
          ],
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
            child: RaisedButton(
                padding: EdgeInsets.all(10),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "PRESS HERE TO ENTER!",
                  style: TextStyle(fontSize: 25),
                ),
                textColor: Colors.white,
                onPressed: () {
                  _enterTeamName();
                })),
      ),
    );
  }
}
