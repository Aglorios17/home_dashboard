// ignore: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_dashboard/constants.dart';
import 'package:home_dashboard/responsive.dart';
import 'package:home_dashboard/screens/components/header.dart';
import 'package:home_dashboard/screens/components/side_menu.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

List<String>? pilots;
List<String>? pilotsScores;
List<String>? contstructors;

class FormulaOne extends StatefulWidget {
  const FormulaOne({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormulaOne createState() => _FormulaOne();
}

class _FormulaOne extends State<FormulaOne> {
   
  @override
  void initState() {
    super.initState();
    loadF1Data();
    //Timer.periodic(const Duration(seconds: 30), (Timer t) => loadGeoRideData());
  }

  Future<void> loadF1Data() async {
    setState(() {
      f1API();
    });
  }

  void f1API() async {
      var dataAPI = jsonDecode(await f1apicall('http://ergast.com/api/f1/current/driverStandings.json'));
      final Map<String, dynamic> data = dataAPI;
      List<dynamic> driverStandings = data['MRData']['StandingsTable']['StandingsLists'][0]['DriverStandings'];
      List<String> names = [];
      List<String> points = [];
      for (var driver in driverStandings) {
        String name = '${driver['Driver']['givenName']} ${driver['Driver']['familyName']}'; // ${driver['Driver']['givenName']} 
        points.add(driver['points'].toString());
        names.add(name);
      }
      pilots = names;
      pilotsScores = points;

      var dataAPI2 = jsonDecode(await f1apicall('https://ergast.com/api/f1/current/constructorStandings.json'));
      final Map<String, dynamic> data2 = dataAPI2;
      List<dynamic> constructorStandings = data2['MRData']['StandingsTable']['StandingsLists'][0]['ConstructorStandings'];
      List<String> constructorNames = [];
      for (var team in constructorStandings) {
        String teamName = team['Constructor']['name'];
        constructorNames.add(teamName);
      }
      contstructors = constructorNames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context)) const Expanded(
              child: SideMenu()
            ),
            const Expanded(
              flex: 5,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Header(name:"Formula One"),
                    SizedBox(height: defaultPadding,),
                    DashboardFormulaOne(),
                  ]
                ),
              )
            ),
            //const Expanded( child: Text(""))
          ],
        )
      ),
    );
  }

  Future<String> f1apicall(String url) async {
    var responseBody = "";
    var request = http.Request('GET', Uri.parse(url));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      responseBody = await response.stream.bytesToString();
    } else {
      developer.log('Failed request: ${await response.stream.bytesToString()}');
    }
    return responseBody;
  }
}

class DashboardFormulaOne extends StatelessWidget {
  const DashboardFormulaOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [ 
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: 
                Column(children: 
                  [
                    Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Column(
                        children: [
                          const TopLineSchedule(),
                          Container(margin: const EdgeInsets.symmetric(vertical: defaultPadding/2), width: double.infinity, height: 2, color:Colors.red),
                          const ScheduleLine(name: "Free Practice", eventDate: "Vendredi 19 Avril", hours: "12:00 UTC",),
                          Container(margin: const EdgeInsets.symmetric(vertical: defaultPadding/2), width: double.infinity, height: 2, color:Colors.red),
                          const ScheduleLine(name: "Grand Prix", eventDate: "Samedi 20 Avril",hours: "16:00 UTC",),
                          Container(margin: const EdgeInsets.symmetric(vertical: defaultPadding/2), width: double.infinity, height: 2, color:Colors.red),
                          const ScheduleLine(name: "Qualifying", eventDate: "Dimanche 21 Avril",hours: "15:00 UTC",)
                        ],
                      ),
                    ),
                    const SizedBox(height: defaultPadding,),
                    Container(
                      width: double.infinity,
                      height: 250,
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: const Column(
                        children: [
                          Text("Live Data", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20))
                        ],
                      ),
                    ),
                  ],
                )
              ),
              const SizedBox(width: defaultPadding,),
              const Expanded(
                  //padding: const EdgeInsets.all(defaultPadding),
                  child: Classement()
              )
            ],
          ),
          const SizedBox(height: defaultPadding,),
          Container(
            width: double.infinity,
            height: 250,
            padding: const EdgeInsets.all(defaultPadding),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: const Column(
              children: [
                Text("Other widget", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20))
              ],
            ),
          ),
        ]
      )
    );
  }
}

class TopLineSchedule extends StatelessWidget {
  const TopLineSchedule({super.key});

  @override
    Widget build(BuildContext context) {
      return const Row(
      children: [
        Expanded(child: 
          Row(
            children: [
              Expanded(child: Icon(Icons.arrow_back, size: 20, color: Colors.black,)), 
              Expanded(flex:4, child: Text("PREVIOUS WEEKEND", textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 10))),
            ],
          )
        ),
        Expanded(flex: 3,  child: Text("WEEKEND SCHEDULE", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 25))),
        Expanded(child: 
          Row(
            children: [                            
              Expanded(flex:4, child: Text("NEXT WEEKEND", textAlign: TextAlign.right, style: TextStyle(color: Colors.black, fontSize: 10))),
              Expanded(child: Icon(Icons.arrow_forward, size: 20, color: Colors.black,)), 
            ],
          )
        ),
      ]
    );
  }
}

class Classement extends StatelessWidget {
  const Classement({super.key});

    @override
  Widget build(BuildContext context) {
    return SafeArea(child:
      Column(children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: const Text("Classements", style: TextStyle(color: Colors.black, fontSize: 30)
          ),
        ), 
        const SizedBox(height: defaultPadding/2,),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: 
          [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(defaultPadding/2),
                alignment: Alignment.center,
                width: double.infinity,
                decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child:
                  Column(children: 
                    [
                      const Text("Pilotes", style: TextStyle(color: Colors.black, fontSize: 25)),
                      for (var i = 1; i <= 21; i++)
                        Column(children: 
                          [
                            Row(
                              children: [
                                Expanded(child: Text(i.toString(), textAlign: TextAlign.left, style: const TextStyle(color: Colors.black, fontSize: 15)),),
                                Expanded(flex: 5, child: Text(pilots![i - 1], textAlign: TextAlign.center, style: const TextStyle(color: Colors.black, fontSize: 15)),),
                                Expanded(child: Text(pilotsScores![i - 1], textAlign: TextAlign.right, style: const TextStyle(color: Colors.black, fontSize: 15)),),
                              ],
                            ),
                            Container(height: 1,  decoration: const BoxDecoration(color: Colors.black),) 
                          ]
                        )
                    ]
                  )
              )
            ),
            const SizedBox(width: defaultPadding / 2 ,),
            Expanded(child:
              Column(children: 
                [
                  Container(
                    padding: const EdgeInsets.all(defaultPadding/2),
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Column(
                      children: [
                        const Text("Constructeurs", style: TextStyle(color: Colors.black, fontSize: 25)),
                        for (var i = 1; i <= 10; i++)
                          Row(
                            children: [                        
                              Expanded(child: Text(i.toString(), textAlign: TextAlign.left , style: const TextStyle(color: Colors.black, fontSize: 15)),),
                              Expanded(flex: 5, child: Text(contstructors![i - 1], textAlign: TextAlign.center, style: const TextStyle(color: Colors.black, fontSize: 15)),),
                              Expanded(child: Container(alignment: Alignment.centerRight, child: const Icon(Icons.flag, color: Colors.black,)))
                            ]
                        ),
                      ]
                    ),
                  ),
                  const SizedBox(height: defaultPadding / 2 ,),
                  Container(
                    padding: const EdgeInsets.all(defaultPadding/2),
                    width: double.infinity,
                    height: 215,
                    decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [Expanded(child:Text("Saison records", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20))),]),
                        Text("Best pit stop", style: TextStyle(color: Colors.black, fontSize: 15)),
                        Text("Most wins", style: TextStyle(color: Colors.black, fontSize: 15)),
                      ]
                    )
                  )
                ]
              )
            ),
          ],
        )
      ])
    );
  } 
}

class ScheduleLine extends StatelessWidget {
  const ScheduleLine({super.key, required this.name, required this.eventDate, required this.hours});
  
  final String name;
  final String eventDate;
  final String hours;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(color: Colors.black, fontSize: 25)),
          Row(
            children: [
              Expanded(child: Text(eventDate, style: const TextStyle(color: Colors.black, fontSize: 15)),),
              Expanded(child: Text(hours, textAlign: TextAlign.end, style: const TextStyle(color: Colors.black, fontSize: 15)),)
            ],
          )
        ]
      )
    );
  }
}