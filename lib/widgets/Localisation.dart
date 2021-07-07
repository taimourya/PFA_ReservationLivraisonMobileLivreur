


import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:livreur/widgets/DrawerMenu.dart';

class Localisation extends StatefulWidget {

  LatLng destination;


  Localisation(this.destination);

  @override
  State<StatefulWidget> createState() {
    return _StateLocalisation();
  }

}

class _StateLocalisation extends State<Localisation>{

  late GoogleMapController mapController;

  LatLng _center = LatLng(33.5761412, -7.5427257);

  String googleAPiKey = "AIzaSyDOQEk6vtt_iOiHrID8gFMlwD-8hxeZYmo";

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }


  late Marker source = Marker(
      markerId: MarkerId('home'),
      position: LatLng(0, 0),
  );

  late Marker destination = Marker(
      markerId: MarkerId('destination'),
      position: widget.destination,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: 'Destination')
  );
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  Future<void> getCurrentPosition() async {

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
    .then((pos) {
      setState(() {
        source = Marker(
            markerId: MarkerId('home'),
            position: LatLng(pos.latitude, pos.latitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            infoWindow: InfoWindow(title: 'Current Location')
        );
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    print("source : ${source.position}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Chemin vers la destination'),
        backgroundColor: Colors.green,
      ),
      drawer: DrawerMenu(),
      body: GoogleMap(
        myLocationEnabled: true,
        markers: {source, destination},
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0
        ),
        onTap: (pos) {
          setState(() {

          });
        },
      ),
    );
  }



}