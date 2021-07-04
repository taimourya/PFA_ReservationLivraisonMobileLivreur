

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livreur/widgets/CommandeTrouver.dart';
import 'package:livreur/widgets/DrawerMenu.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:livreur/API/Host.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Home extends StatefulWidget {

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  bool disponnible = false;

  Timer? timer;

  late int userId;


  @override
  void initState() {
    super.initState();
    getSharedUserId();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => checkCommande());
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> getSharedUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');
    print(id);
    setState(() {
      userId = id == null? 0 : id;
    });
  }

  void checkCommande() {
      if(disponnible) {
        var url = Uri.parse("http://${Host.url}:8080/livraison/check?livreur_id=$userId");

        http.get(url).then((response) {
          print(response.body);
          dynamic data = json.decode(response.body);
          if(response.statusCode == 200) {
            print("id liv : ${data['id']}");
            setState(() {
              disponnible = false;
              timer?.cancel();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommandeTrouver(data['id'])),
              );
            });
          }
          else {
            if(data['message'] == "vous avez deja une livraison en cours")
            {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(data['message'])));
              setState(() {
                disponnible = false;
              });
            }
          }
        }).catchError((err) {
          print(err);
        });
      }
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