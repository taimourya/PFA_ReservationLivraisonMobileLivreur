


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livreur/widgets/ItemsList.dart';
import 'package:url_launcher/url_launcher.dart';

class LivraisonEnCours extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateLivraisonEnCours();
  }

}

class _StateLivraisonEnCours extends State<LivraisonEnCours>{



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
            title: Text('nom complet : ' + "taimourya" + " " + "yahya"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('téléphone : ' + "0643334135"),
          ),
        ),
        SizedBox(height: 20,),
        Text(
            "Commande Information",
            style: Theme.of(context).textTheme.headline5
        ),
        Card(
          child: ListTile(
            title: Text('id : ' + "5698"),
          ),
        ),Card(
          child: ListTile(
            title: Text('Etat : ' + "En cours de recolte"),
          ),
        ),
        Expanded(
            child: ItemsList()
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                child: Text("Voir le chemin sur google map"),
                onPressed: () {
                  openMap(-3.823216,-38.481700);
                },
              ),
            )
          ],
        ),
        Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  child: Text("Etat Suivante"),
                  onPressed: () {

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