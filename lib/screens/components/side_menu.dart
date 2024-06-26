import 'package:flutter/material.dart';
import 'package:home_dashboard/screens/cctv.dart';
import 'package:home_dashboard/screens/crypto.dart';
import 'package:home_dashboard/screens/formulaone.dart';
import 'package:home_dashboard/screens/georide.dart';
import 'package:home_dashboard/screens/home.dart';
import 'package:home_dashboard/screens/profile.dart';
import 'package:home_dashboard/screens/settings.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        child: SingleChildScrollView( 
          child: Column(children: [
            DrawerHeader(child: /*Icon(Icons.api, size: 100,),*/ Image.asset('images/fsociety.png'),
            ),
            ListTile(leading: const Icon(Icons.dashboard, color: Colors.white,),
                    title: const Text("Dashboard"),
                    onTap: () {
                      Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                      ),
                    );
                    },
            ),
            ListTile(leading: const Icon(Icons.currency_bitcoin, color: Colors.white,),
                  title: const Text("Crypto"),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const Crypto(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  }
            ),
            ListTile(leading: const Icon(Icons.motorcycle, color: Colors.white,),
                  title: const Text("Georide"),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const Georide(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
            ),
            ListTile(
                  leading:
                  Image.asset('images/F1.png', height: 6.5),
                  title: const Text("Formula One"),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const FormulaOne(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
            ),
            ListTile(leading: const Icon(Icons.camera, color: Colors.white,),
                  title: const Text("CCTV"),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const Cctv(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
            ),
            ListTile(leading: const Icon(Icons.person, color: Colors.white,),
                  title: const Text("Profile"),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const Profile(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
            ),
            ListTile(leading: const Icon(Icons.settings, color: Colors.white,),
                  title: const Text("Settings"),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const Settings(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
            ),
          ],),
        ),
      ),
    );
  }
}