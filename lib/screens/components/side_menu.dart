import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        child: SingleChildScrollView( 
          child: Column(children: [
            const DrawerHeader(child: Icon(Icons.home),
            ),
            ListTile(leading: const Icon(Icons.dashboard, color: Colors.white,),
                    title: const Text("Dashboard"),
                    onTap: () {},
            ),
            ListTile(leading: const Icon(Icons.currency_bitcoin, color: Colors.white,),
                  title: const Text("Crypto"),
                  onTap: () {},
            ),
            ListTile(leading: const Icon(Icons.motorcycle, color: Colors.white,),
                  title: const Text("Georide"),
                  onTap: () {},
            ),
            ListTile(leading: const Icon(Icons.person, color: Colors.white,),
                  title: const Text("Profile"),
                  onTap: () {},
            ),
            ListTile(leading: const Icon(Icons.settings, color: Colors.white,),
                  title: const Text("Settings"),
                  onTap: () {},
            ),
          ],),
        ),
      ),
    );
  }
}
