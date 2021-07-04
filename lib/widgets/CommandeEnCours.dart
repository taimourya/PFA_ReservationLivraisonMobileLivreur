


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livreur/widgets/DrawerMenu.dart';
import 'package:livreur/widgets/LivraisonEnCours.dart';

class CommandeEnCours extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateCommandeEnCours();
  }


}

class _StateCommandeEnCours extends State<CommandeEnCours>{



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Livraison en cours"),
        ),
        drawer: DrawerMenu(),
        body:  LivraisonEnCours(),
    );
  }



}