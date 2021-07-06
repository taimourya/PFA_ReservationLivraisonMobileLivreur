import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:livreur/API/Host.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatefulWidget {

  @override
  _ProfilState createState() {
    return _ProfilState();
  }
}

class _ProfilState extends State<Profil> {

  dynamic data;

  Duration get loginTime => Duration(milliseconds: 100);
  late int userId;

  @override
  void initState() {
    super.initState();
    getSharedUserId();
    Future.delayed(loginTime).then((_) {
      _getProfil();
    });
  }

  Future<void> getSharedUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');
    print(id);
    setState(() {
      userId = id == null? 0 : id;
    });
  }

  void _getProfil() {
    var url = Uri.parse("${Host.url}/user?id=$userId");
    http.get(url)
        .then((response) {
      print(response.body);
      setState(() {
        data = json.decode(response.body);
      });
    })
        .catchError((err) {
      print(err);
    });
  }

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
            leading: Text("prenom"),
            title: Text("${data != null?data['firstname'] : ''}"),
          ),
        ),
        Card(
          child: ListTile(
            leading: Text("nom"),
            title: Text("${data != null?data['lastname'] : ''}"),
          ),
        ),
        Card(
          child: ListTile(
            leading: Text("email"),
            title: Text("${data != null?data['email'] : ''}"),
          ),
        ),
        Card(
          child: ListTile(
            leading: Text("ville"),
            title: Text("${data != null?data['ville'] : ''}"),
          ),
        ),
        Card(
          child: ListTile(
            leading: Text("adresse"),
            title: Text("${data != null?data['adresse'] : ''}"),
          ),
        ),
        Card(
          child: ListTile(
            leading: Text("telephone"),
            title: Text("${data != null?data['phone'] : ''}"),
          ),
        ),
        Card(
          child: ListTile(
            leading: Text("CIN"),
            title: Text("${data != null?data['cin'] : ''}"),
          ),
        ),
        Card(
          child: ListTile(
            leading: Text("Date de naissance"),
            title: Text("${data != null?DateFormat('yyyy-MM-dd').format(DateTime.parse(data['dateNaissance'])):''}"),
          ),
        ),
      ],
    );
  }
}