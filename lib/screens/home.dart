import 'package:flutter/material.dart';
import 'package:home_dashboard/responsive.dart';
import 'package:home_dashboard/screens/components/side_menu.dart';
import 'package:home_dashboard/screens/dashboard/dashboard_screen.dart';


class HomeScreen extends StatelessWidget {
   const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            if (Responsive.isDesktop(context)) const Expanded(
              child: SideMenu()
            ),
            const Expanded(
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        )
      ),
    );
  }
}

