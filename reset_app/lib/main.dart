import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

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

  void deleteData() {
    database.child('pressedTeams').remove();
  }

  void getData() {
    database.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
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
            width: MediaQuery.of(context).size.width * 0.8,
            color: Color.fromRGBO(10, 10, 10, 30),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text('hello world'),
                  Text('hello world'),
                  Text('hello world'),
                  SizedBox(height: 35),
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
                            onPressed: () => getData),
                      ),
                      Container(
                        width: 120,
                        child: RaisedButton(
                            color: Colors.red,
                            child: Text('RESET',
                                style: GoogleFonts.lato(fontSize: 20)),
                            onPressed: () => deleteData),
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
