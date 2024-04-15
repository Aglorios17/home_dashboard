import 'package:flutter/material.dart';
import 'package:home_dashboard/screens/cctv.dart';
import 'package:home_dashboard/screens/crypto.dart';
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
            DrawerHeader(child: Image.asset('images/fsociety.png'),
            ),
            ListTile(leading: const Icon(Icons.dashboard, color: Colors.white,),
                    title: const Text("Dashboard"),
                    onTap: () {
                      Navigator.push(
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
                    Navigator.push(
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
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const Georide(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
            ),
            ListTile(leading: const Icon(Icons.camera, color: Colors.white,),
                  title: const Text("CCTV"),
                  onTap: () {
                    Navigator.push(
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
                    Navigator.push(
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
                    Navigator.push(
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