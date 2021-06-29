



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livreur/widgets/Item.dart';


class ItemsList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return StatItemList();
  }
}

class StatItemList extends State<ItemsList> {

  String searchText = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(CupertinoIcons.map_fill),
              title: Text('Item ${index}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${"35"} DH"),
                  SizedBox(width: 20,),
                  Text("X${'1'}"),
                ],
              ),
              subtitle: Text("Par ${'MCDO'}"),

            ),
          );
        },
    );
  }
}