

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livreur/widgets/DrawerMenu.dart';
import 'package:livreur/widgets/Historique.dart';
import 'package:livreur/widgets/Profil.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StatSettings();
  }
}

class StatSettings extends State<Settings> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Settings"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.supervised_user_circle)),
              Tab(icon: Icon(Icons.bar_chart)),
            ],
          ),
        ),
        drawer: DrawerMenu(),
        body: TabBarView(
          children: <Widget>[

            Profil(),

            Historique(),

          ],
        ),
      )
    );
  }


}