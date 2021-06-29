


import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:livreur/widgets/DrawerMenu.dart';


class Localisation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateLocalisation();
  }

}

class _StateLocalisation extends State<Localisation>{

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(33.5761412, -7.5427257);

  late Marker source = Marker(
      markerId: MarkerId('home'),
      position: LatLng(0, 0),
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Localisez votre position'),
        backgroundColor: Colors.green,
        actions: [
          TextButton(
              child: Text("Envoyer", style: TextStyle(color: Colors.cyan, fontSize: 15),),
              onPressed: () {
                if(source.position.latitude != 0 || source.position.longitude != 0) {

                }
                else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('choisisez une position')));
                }
              }
          )
        ],
      ),
      drawer: DrawerMenu(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching),
        onPressed: () {

        },
      ),
      body: GoogleMap(
        markers: {source},
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0
        ),
        onTap: (pos) {
          setState(() {
            source = Marker(
                markerId: MarkerId('home'),
                position: pos,
                icon: BitmapDescriptor.defaultMarker,
                infoWindow: InfoWindow(title: 'Current Location')
            );
          });
        },
      ),
    );
  }

}