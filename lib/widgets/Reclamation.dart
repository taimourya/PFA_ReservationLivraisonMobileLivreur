


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livreur/widgets/DrawerMenu.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:livreur/API/Host.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Reclamation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StatReclamation();
  }
}

class StatReclamation extends State<Reclamation> {

  String message = "";
  final _formKey = GlobalKey<FormState>();

  Duration get loginTime => Duration(milliseconds: 100);
  late int userId;

  @override
  void initState() {
    super.initState();
    getSharedUserId();

  }
  Future<void> getSharedUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');
    print(id);
    setState(() {
      userId = id == null? 0 : id;
    });
  }

  addReclamation() {
    http.post(
      Uri.parse('${Host.url}/create/reclamation'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        'user_id': this.userId,
        'message': this.message,
      }),
    ).then((response) {
      print(response.body);
      if(response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Votre message a bien été envoyer')));
      }
    });

  }

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
                      addReclamation();
                      _formKey.currentState!.reset();
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