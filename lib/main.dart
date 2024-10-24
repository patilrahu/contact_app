import 'package:contactapp/feature/contact/ui/contact_list.dart';
import 'package:contactapp/feature/welcome/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',theme:  ThemeData(fontFamily: GoogleFonts.nunito().fontFamily),
      home:  const Welcome(),
    );
  }
}