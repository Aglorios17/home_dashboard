import 'package:flutter/material.dart';
import 'package:home_dashboard/constants.dart';
import 'package:home_dashboard/responsive.dart';
import 'package:home_dashboard/screens/components/header.dart';
import 'package:home_dashboard/screens/components/side_menu.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
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
                    Header(name:"Profile"),
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