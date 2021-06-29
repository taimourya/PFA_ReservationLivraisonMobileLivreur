

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Historique extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HistoriqueStat();
  }
}

class HistoriqueStat extends State<Historique> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 35,),
        Text(
          "Historique",
          style: Theme.of(context).textTheme.headline4
        ),
      ],
    );
  }


}