import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class DynamaxScreen extends StatefulWidget {
  @override
  _DynamaxScreenState createState() => _DynamaxScreenState();
}

class _DynamaxScreenState extends State<DynamaxScreen> {
  int completed = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamax Adventures'),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Completed Adventures:'),
                Text(completed.toString()),
                Text(
                  'Chance there WON\'T be a Shiny in the next Dynamax Adventure:',
                  textAlign: TextAlign.center,
                ),
                Text(calculateChances()),
                Text('Were any of the Pokémon Shiny this time?'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        child: Text('No'),
                        onPressed: () {
                          setState(() {
                            completed++;
                          });
                          saveCompleted();
                        }),
                    ElevatedButton(
                        child: Text('Yes'),
                        onPressed: () {
                          setState(() {
                            completed = 0;
                          });
                          saveCompleted();
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String calculateChances() {
    int chance = (pow(.99, (completed + 1) * 4) * 100).toInt();
    return '$chance%';
  }

  void saveCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('dynaComplete', completed);
  }

  Future<int> getCompletedAdventures() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('dynaComplete');
  }
}
