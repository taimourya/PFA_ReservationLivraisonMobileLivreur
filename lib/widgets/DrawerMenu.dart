


import 'package:livreur/widgets/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livreur/widgets/CommandeEnCours.dart';
import 'package:livreur/widgets/Reclamation.dart';
import 'package:livreur/widgets/Settings.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Restaurant Application'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('ma commande'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommandeEnCours()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text('Réclamation'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Reclamation()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
          ),
        ],
      ),
    );
  }

}