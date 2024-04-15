import 'package:flutter/material.dart';
import 'package:home_dashboard/responsive.dart';
import 'package:home_dashboard/screens/components/side_menu.dart';

class Crypto extends StatelessWidget {
  const Crypto({super.key});
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
              child: Text("hello crypto"),
            ),
          ],
        )
      ),
    );
  }
}