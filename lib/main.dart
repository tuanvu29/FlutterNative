
import 'package:flutter/material.dart';

import 'screens/my_home_screen.dart';

void main() {
  runApp(MinHverdag());
}

class MinHverdag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TRYG Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}


