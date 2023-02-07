import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sellers_app/firebase_options.dart';
import 'package:sellers_app/global/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splashScreen/my_splash_screen.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: Platform.isWindows ? DefaultFirebaseOptions.web : DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sellers App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MySplashScreen(),
    );
  }
}

