


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livreur/widgets/ItemsList.dart';

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


}