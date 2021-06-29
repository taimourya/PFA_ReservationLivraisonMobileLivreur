

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livreur/widgets/DrawerMenu.dart';

class Reclamation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StatReclamation();
  }
}

class StatReclamation extends State<Reclamation> {

  String message = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reclamation"),
        backgroundColor: Colors.green,
      ),
      drawer: DrawerMenu(),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 100,),
            Text(
                "avez vous rencontré des problèmes ?",
                style: Theme.of(context).textTheme.headline6
            ),
            SizedBox(height: 50,),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "decrivez nous votre problème !",
                      prefixIcon: Icon(Icons.mail),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vous devez saisire le message';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    this.setState(() {
                      this.message = value;
                    });
                  },
                ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Votre message a bien été envoyer')));
                  }
                },
                child: Text('Envoyer'),
              ),
            ),
          ],
        ),
      )
    );
  }


}