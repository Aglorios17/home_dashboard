import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_dashboard/constants.dart';
import 'package:home_dashboard/screens/components/header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(),
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
}

