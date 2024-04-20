import 'package:home_dashboard/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_dashboard/screens/formulaOne.dart';
import 'package:home_dashboard/screens/georide.dart';
import 'package:home_dashboard/screens/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:universal_html/js.dart' as js;
import 'package:universal_html/html.dart' as html;

Future<void> main() async {
  await dotenv.load();

  //To expone the dart variable to global js code
  js.context['googleMapsApiKey'] = dotenv.env['GOOGLE_API'];
  //Custom DOM event to signal to js the execution of the dart code
  html.document.dispatchEvent(html.CustomEvent("google-maps-api-key-loaded"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: const HomeScreen()
    );
  }
}