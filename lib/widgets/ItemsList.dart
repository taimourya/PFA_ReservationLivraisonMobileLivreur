



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livreur/widgets/Item.dart';


class ItemsList extends StatefulWidget {

  dynamic data;

  ItemsList(this.data);

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
        itemCount: widget.data != null? widget.data.length:0,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(CupertinoIcons.map_fill),
              title: Text("${widget.data[index]['buyable']['name']}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${widget.data[index]['buyable']['price']} DH"),
                  SizedBox(width: 20,),
                  Text("X${widget.data[index]['qtn']}"),
                ],
              ),
              subtitle: Text("Par ${widget.data[index]['buyable']['restaurant']['name']}"),

            ),
          );
        },
    );
  }
}