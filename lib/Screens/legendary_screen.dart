import 'package:flutter/material.dart';

class LegendaryScreen extends StatefulWidget {
  @override
  _LegendaryScreenState createState() => _LegendaryScreenState();
}

class _LegendaryScreenState extends State<LegendaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamax Legendaries'),
      ),
      body: SafeArea(),
    );
  }
}
