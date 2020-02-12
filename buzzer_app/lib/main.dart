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
      ),
    );
  }
}
