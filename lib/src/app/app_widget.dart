import 'package:flutter/material.dart';
import 'package:smart_place_app/src/pages/home/home_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Place Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.greenAccent[400]
      ),
      home: HomeModule(),
    );
  }
}
