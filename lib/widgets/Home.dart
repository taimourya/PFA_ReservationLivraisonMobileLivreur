

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livreur/widgets/DrawerMenu.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  bool disponnible = false;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => checkCommande());
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void checkCommande() {
      if(disponnible)
        print("recherche ...");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.green,
      ),
      drawer: DrawerMenu(),
      backgroundColor: disponnible? Colors.red: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            disponnible?
            RawMaterialButton(
              onPressed: () {
                setState(() {
                  disponnible = false;
                });
              },
              elevation: 2.0,
              fillColor: Colors.green,
              child: Icon(
                Icons.pause,
                size: 35.0,
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
            )
                :
            RawMaterialButton(
              onPressed: () {
                setState(() {
                  disponnible = true;
                });

              },
              elevation: 2.0,
              fillColor: Colors.red,
              child: Icon(
                Icons.not_started,
                size: 35.0,
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
            ),

            SizedBox(height: 20,),
            Text(
              disponnible? "En cours Recherche" : "Non disponible",
              style: Theme.of(context).textTheme.headline5,
            ),

          ],
        )

      ),
    );
  }
}