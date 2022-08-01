import 'package:flutter/material.dart';
import 'package:wishes/SplashScreen/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wishes',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
