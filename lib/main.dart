import 'package:flutter/material.dart';
import 'package:uas/FormInput.dart';
import 'package:uas/Home.dart';

import 'ButtonNavigasi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ButtonNavigasi(),
    );
  }
}
