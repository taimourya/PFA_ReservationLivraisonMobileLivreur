


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:livreur/widgets/CommandeTerminer.dart';
import 'package:livreur/widgets/Home.dart';
import 'package:livreur/widgets/ItemsList.dart';
import 'package:livreur/widgets/Localisation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:livreur/API/Host.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LivraisonEnCours extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateLivraisonEnCours();
  }

}

class _StateLivraisonEnCours extends State<LivraisonEnCours>{


  dynamic data;
  dynamic dataItems;
  Duration get loginTime => Duration(milliseconds: 100);
  late int userId;

  @override
  void initState() {
    super.initState();
    getSharedUserId();
    Future.delayed(loginTime).then((_) {
      _getLivraison();
      _getItemsLivraison();
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

  void _getLivraison() {
    var url = Uri.parse("${Host.url}/livraison/enCours?livreur_id=$userId");

    http.get(url).then((response) {
      print(response.body);
      if(response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
        });
      }
      else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _getItemsLivraison() {
    var url = Uri.parse("${Host.url}/livraison/enCours/items?livreur_id=$userId");

    http.get(url).then((response) {
      print(response.body);
      if(response.statusCode == 200) {
        setState(() {
          dataItems = json.decode(response.body);
        });
      }
      else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
    }
    }).catchError((err) {
      print(err);
    });
  }

  void _nextStep() {
    var url = Uri.parse("${Host.url}/livraison/nextStep?livreur_id=$userId");

    http.get(url).then((response) {
      print(response.body);
      if(response.statusCode == 200) {
        if(response.body == "livrer") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CommandeTerminer()),
          );
        }
        else {
          _getLivraison();
        }
      }
      else {
        data = json.decode(response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${data['message']}")));
      }
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Text(
            "Livraison en cours",
            style: Theme.of(context).textTheme.headline4
        ),
        SizedBox(height: 20,),
        Text(
            "Client Information",
            style: Theme.of(context).textTheme.headline5
        ),
        Card(
          child: ListTile(
            leading: Text("nom complet"),
            title: Text(
              data != null? "${data['client']['firstname']} ${data['client']['firstname']}" : ''
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Text("Téléphone"),
            title: Text(
                data != null? "${data['client']['phone']}" : ''
            ),
          ),
        ),
        SizedBox(height: 20,),
        Text(
            "Commande Information",
            style: Theme.of(context).textTheme.headline5
        ),
        Card(
          child: ListTile(
            leading: Text("id"),
            title: Text(
                data != null? "${data['id']}" : ''
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Text("Etat"),
            title: Text(
                data != null?
                data['stat'] == 1? 'En cours de recolte' :
                data['stat'] == 2? 'En route' :
                data['stat'] == 3? 'Livré' : ''
                    :
                ''
            ),
          ),
        ),
        Expanded(
            child: ItemsList(dataItems)
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                child: Text("Voir le chemin sur google map"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Localisation(
                      LatLng(data != null? data['latitude']: 0, data != null? data['longitude']: 0)
                    )),
                  );
                },
              ),
            )
          ],
        ),
        Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  child: Text("Etape Suivante"),
                  onPressed: () {
                    _nextStep();
                  },
                ),
              )
            ],
        ),
      ]
    );
  }

  Future<void> openMap(double latitude, double longitude) async {
    //String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    String googleUrl = 'https://www.google.com/maps/dir/?api=1&origin=Space+Needle+Seattle+WA&destination=Pike+Place+Market+Seattle+WA&travelmode=bicycling';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

}