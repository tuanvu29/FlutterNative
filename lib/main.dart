
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(TrygDemo());
}

class TrygDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TRYG Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}


