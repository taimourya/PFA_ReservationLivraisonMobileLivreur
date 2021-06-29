
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livreur/widgets/CommandeEnCours.dart';
import 'package:livreur/widgets/DrawerMenu.dart';
import 'package:livreur/widgets/Home.dart';

class CommandeTrouver extends StatefulWidget {

  @override
  _CommandeTrouverState createState() {
    return _CommandeTrouverState();
  }
}

class _CommandeTrouverState extends State<CommandeTrouver> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.green,
      ),
      drawer: DrawerMenu(),
      body: Column(
        children: [
          SizedBox(height: 35,),
          Text(
              "Commande trouver !",
              style: Theme.of(context).textTheme.headline4
          ),
          SizedBox(height: 80,),
          Row(
            children: [
              SizedBox(width: 10,),

              Expanded(
                child: ElevatedButton(
                  child: Text("Accepter"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CommandeEnCours()),
                    );
                  },
                ),
              ),

              SizedBox(width: 10,),

              Expanded(
                child: ElevatedButton(
                  child: Text("Refuser"),
                  onPressed: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                  },
                ),
              ),

              SizedBox(width: 10,),
            ],
          )
        ],
      )
    );
  }
}