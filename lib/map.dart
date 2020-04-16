import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'main.dart';

class Map extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MapState();
}

class MapState extends State<Map>{
var location = new Location();
Future<Location> _coords;
MapType _currentMapType = MapType.satellite;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: _currentMapType,
            onMapCreated: (GoogleMapController gmc) => {},
            initialCameraPosition: CameraPosition(
              target: LatLng(42.521563, -122.677433),
              zoom: 11.0,
            ),
          ),
          FloatingActionButton(
            child: Icon(Icons.gps_fixed),
            onPressed: (){
              setState(() {
                _currentMapType = _currentMapType == MapType.satellite ? MapType.normal : MapType.satellite;
              });
            },
          )
        ],
      ),
    );
  }

  Future<void> _getLocation() async{
    print('looking for coords');
    var coords = await location.getLocation();
    //print(jsonDecode(coords));
  }
}