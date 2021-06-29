import 'package:flutter/material.dart';

class Profil extends StatefulWidget {

  @override
  _ProfilState createState() {
    return _ProfilState();
  }
}

class _ProfilState extends State<Profil> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 35,),
        Text(
            "Your Profil",
            style: Theme.of(context).textTheme.headline4
        ),
        SizedBox(height: 40,),
        Card(
          child: ListTile(
            title: Text('prenom : ' + "taimourya"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('nom : ' +  "yahya"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('adresse : ' + "db ghelef rue 10"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('telephone : ' + "0643334135"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('cin : ' + "BE266985"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('date naissance : ' + "1998-11-19"),
          ),
        ),
      ],
    );
  }
}