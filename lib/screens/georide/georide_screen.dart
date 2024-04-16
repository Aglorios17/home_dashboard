import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_dashboard/constants.dart';
import 'package:home_dashboard/screens/components/header.dart';
import 'package:home_dashboard/screens/georide/map.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String USERNAME = "";
double latitude = 0;
double longitude = 0;

class GeorideScreen extends StatelessWidget {
  const GeorideScreen({super.key});

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
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () async {
                        // Call the function to fetch the token
                        await georideAPI();
                        await Future.delayed(const Duration(milliseconds: 200));
                        // Show a dialog box with the fetched username
                        showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("USERNAME"),
                              content: GeorideMap(latitude: latitude, longitude: longitude),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Api'),
                    )
                  ),
                ),
                const SizedBox(width: defaultPadding,),
                Expanded(
                  child: Container(
                    height: 500,
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
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
      developer.log(jsonResponse['firstName']);
      USERNAME = jsonResponse['firstName'];

      jsonResponse = jsonDecode(await georideCall(accessToken, 'GET', 'https://api.georide.com/user/trackers'));
      double km = jsonResponse[0]['odometer'] as double;
      km = km / 1000;

      developer.log(
        jsonResponse[0]['latitude'].toString() + ", ".toString()
          + jsonResponse[0]['longitude'].toString() + ", ".toString()
          + km.toString() + "km".toString());
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
      developer.log('Failed request: ${response.reasonPhrase}');
    }
    return responseBody;
  }

}