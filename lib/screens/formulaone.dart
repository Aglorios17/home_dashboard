import 'package:flutter/material.dart';
import 'package:home_dashboard/constants.dart';
import 'package:home_dashboard/responsive.dart';
import 'package:home_dashboard/screens/components/header.dart';
import 'package:home_dashboard/screens/components/side_menu.dart';

class FormulaOne extends StatelessWidget {
  const FormulaOne({super.key});

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
            )
          ],
        )
      ),
    );
  }
}

class DashboardFormulaOne extends StatelessWidget {
  const DashboardFormulaOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child:
            Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Column(
                children: [
                  const Text("WEEKEND SCHEDULE", style: TextStyle(color: Colors.black, fontSize: 30)),
                  Container(margin: const EdgeInsets.symmetric(vertical: defaultPadding/2), width: double.infinity, height: 2, color:Colors.red),
                  const ScheduleLine(name: "Free Practice", eventDate: "Vendredi 20 Avril", hours: "12:00 UTC",),
                  Container(margin: const EdgeInsets.symmetric(vertical: defaultPadding/2), width: double.infinity, height: 2, color:Colors.red),
                  const ScheduleLine(name: "Grand Prix", eventDate: "Samedi 21 Avril",hours: "16:00 UTC",),
                  Container(margin: const EdgeInsets.symmetric(vertical: defaultPadding/2), width: double.infinity, height: 2, color:Colors.red),
                  const ScheduleLine(name: "Qualifying", eventDate: "Dimanche 22 Avril",hours: "15:00 UTC",)
                ],
              ),
            ),
          ),
          const SizedBox(width: defaultPadding,),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: const Text("TEST")
            )
          )
        ],
      )
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