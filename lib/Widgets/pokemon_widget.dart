import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  PokemonCard({this.dexNo, this.name});

  final int dexNo;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                '#${dexNo.toString().padLeft(3, '0')}',
              ),
              Text('$name'),
            ],
          ),
        ],
      ),
    );
  }
}
