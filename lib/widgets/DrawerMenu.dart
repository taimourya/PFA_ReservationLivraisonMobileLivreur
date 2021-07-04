


import 'package:livreur/widgets/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livreur/widgets/CommandeEnCours.dart';
import 'package:livreur/widgets/Login.dart';
import 'package:livreur/widgets/Reclamation.dart';
import 'package:livreur/widgets/Settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenu extends StatelessWidget {

  Future<void> removeSharedUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_id');
  }


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
            child: Text('Livreur Application'),
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
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              removeSharedUserId();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
    );
  }

}