import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_dashboard/constants.dart';
import 'package:home_dashboard/screens/components/header.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:flutter_dotenv/flutter_dotenv.dart';


String USERNAME = "";
double latitude = 50.499527;
double longitude = 4.475402500000001;
String odometer = "";
double ZOOM = 15;

class GeorideScreen extends StatefulWidget {
  const GeorideScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GeorideScreen createState() => _GeorideScreen();
}

class _GeorideScreen extends State<GeorideScreen> {



  @override
  void initState() {
    super.initState();
    loadGeoRideData();
    //Timer.periodic(const Duration(seconds: 30), (Timer t) => loadGeoRideData());
  }

  Future<void> loadGeoRideData() async {
    setState(() {
      georideAPI();
      // Update latitude and longitude values
      latitude = latitude/* Get latitude value from your georideAPI response */;
      longitude = longitude/* Get longitude value from your georideAPI response */;
      USERNAME = USERNAME;
      ZOOM = 15;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(name:"Georide"),
            const SizedBox(height: defaultPadding,),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 500,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child:GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(latitude, longitude),
                          zoom: ZOOM,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId(USERNAME),
                            position: LatLng(latitude, longitude),
                            // Add any additional marker properties here
                          ),
                        }
                      ),
                    )
                  )
                ),
                const SizedBox(width: defaultPadding,),
                Expanded(
                  child: Container(
                    height: 500,
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                    child: Column(
                      children: [
                        Text(USERNAME),
                        Text(odometer),
                        ]
                      )
                  ),
                ),
              ]
            )
          ]
        ),
      ),
    );
  }

  Future<void> georideAPI() async {
      var jsonResponse = jsonDecode(await georideCall("", 'POST', 'https://api.georide.com/user/login'));
      
      var accessToken = jsonResponse['authToken'];

      //developer.log('Access Token: $accessToken');
      jsonResponse = jsonDecode(await georideCall(accessToken, 'GET', 'https://api.georide.com/user'));
      //developer.log(jsonResponse['firstName']);
      USERNAME = jsonResponse['firstName'];

      jsonResponse = jsonDecode(await georideCall(accessToken, 'GET', 'https://api.georide.com/user/trackers'));
      double km = jsonResponse[0]['odometer'] as double;
      km = km / 1000;
      latitude = jsonResponse[0]['latitude'];
      longitude = jsonResponse[0]['longitude'];
      odometer = km.toString();
      ZOOM = 15;
  }

  Future<String> georideCall(String token, String method, String url) async {
    var responseBody = "";
    var headers = {
        'Authorization': 'Bearer $token',
    };
    if (token == "") {
      headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
      };
    }
    var request = http.Request(method, Uri.parse(url));
    request.headers.addAll(headers);
    if (token == ""){
      request.bodyFields = {
      'email': dotenv.env['Georide_email'].toString(),
      'password': dotenv.env['Georide_password'].toString()
    };
    }
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      responseBody = await response.stream.bytesToString();
    } else {
      developer.log('Failed request: ${await response.stream.bytesToString()}');
    }
    return responseBody;
  }
}