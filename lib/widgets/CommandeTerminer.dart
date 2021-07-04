import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livreur/widgets/DrawerMenu.dart';
import 'package:livreur/widgets/Home.dart';

class CommandeTerminer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Livraison en cours"),
      ),
      drawer: DrawerMenu(),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/images/smiley.png"),),
            SizedBox(height: 20,),
            Text("Livraison effecutué!", style: Theme.of(context).textTheme.headline4,),
            SizedBox(height: 20,),
            TextButton(
              child: Text("Attendre une autre commande", style: Theme.of(context).textTheme.overline,),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
