// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng mylatlong = LatLng(24.977852454822045, 67.06720142676798);
  
  String address = "North Karachi";

  setMarker (LatLng value) async{
    mylatlong = value;
    List<Placemark> result = await placemarkFromCoordinates(value.latitude, value.longitude);
    if (result.isNotEmpty) {
      address = "${result[0].name}, ${result[0].locality} ${result[0].administrativeArea}";
    }
    setState(() {
      
    });
    Fluttertoast.showToast(msg: "📍" + address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
        target: mylatlong,
        zoom: 12,
      ),
      markers: {
        Marker(
          infoWindow: InfoWindow(title: address),
          position: mylatlong,
          draggable: true,
          markerId: MarkerId("1"),
          onDragEnd: (value){
            setMarker(value);
          })
      },
      onTap: (value){
        setMarker(value);
      },
      ),
      
    );
  }
}
