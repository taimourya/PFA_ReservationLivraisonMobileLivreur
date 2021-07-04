

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:livreur/API/Host.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Historique extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HistoriqueStat();
  }
}

class HistoriqueStat extends State<Historique> {

  dynamic data;

  Duration get loginTime => Duration(milliseconds: 100);
  late int userId;

  @override
  void initState() {
    super.initState();
    getSharedUserId();
    Future.delayed(loginTime).then((_) {
      _getHistorique();
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

  void _getHistorique() {
    var url = Uri.parse("http://${Host.url}:8080/livraison/historique?livreur_id=$userId");
    http.get(url).then((response) {
      print(response.body);
      setState(() {
        data = json.decode(response.body);
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 35,),
        Text(
            "Historique",
            style: Theme.of(context).textTheme.headline4
        ),
        SizedBox(height: 40,),

        data!=null?(data.length == 0? Text("Aucun element trouver") : Text("")) : Text(""),

        Expanded(
          child: ListView.builder(

            itemCount: data!=null? data.length : 0,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Text(
                          (data[index]['stat'] == 0?"recherche" : "") +
                          (data[index]['stat'] == 1?"recolte" : "") +
                          (data[index]['stat'] == 2?"chemin" : "") +
                          (data[index]['stat'] == 3?"livré" : "")
                  ),
                  title: Text("${DateFormat('yyyy-MM-dd :: HH:mm:ss').format(DateTime.parse(data[index]['date']))}"),
                  subtitle: Text(
                      "${data[index]['livredDate'] != null?
                            DateFormat('yyyy-MM-dd :: HH:mm:ss').format(DateTime.parse(data[index]['livredDate'])) :
                      ''}"
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

}