// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({Key? key}) : super(key: key);

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  String coordinates = "No location found";
  String address = "No address found";
  bool scanning = false;

  checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      Fluttertoast.showToast(msg: "Request Denied!");
      return;
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: "Denied forever!");
      return;
    }
    getLocation();
  }

  getLocation() async {
    setState(() {
      scanning = true;
    });
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      coordinates =
          "Latitude : ${position.latitude} \nLongitude : ${position.latitude}";
      List<Placemark> result = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      if (result.isNotEmpty) {
        address =
            "${result[0].name}, ${result[0].locality} ${result[0].administrativeArea}";
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "${e.toString()}");
    }
    setState(() {
      scanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Location'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/location.png",
                width: 202,
                height: 202,
              ),
              const SizedBox(height: 20),
              Text(
                'Current Coordinates',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              scanning
                  ? SpinKitThreeBounce(
                      size: 20,
                      color: Color(0xFF03F337),
                    )
                  : Text(
                      "$coordinates",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              const SizedBox(height: 40),
              Divider(thickness: 4,),
              const SizedBox(height: 40),
              Text(
                'Current Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              scanning
                  ? SpinKitThreeBounce(
                      size: 20,
                      color: Color(0xFF03F337),
                    )
                  : Text(
                      "$address",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              const SizedBox(height: 80),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    checkPermission();
                  },
                  icon: Icon(Icons.location_on),
                  label: Text("Get Current Location"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
