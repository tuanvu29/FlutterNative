import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

import 'package:tryg_poc_component1/tryg_poc_component1.dart';


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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = <String, dynamic>{};
    double width = MediaQuery.of(context).size.width;

      return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child:SingleChildScrollView(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("TRYG forsikrings app"),
            Container(child: _getName(creationParams), height: 100, width: width),
            _getAgeDisplayName("Peter Petersen"),
            Container(child: _displayNameAndAge(creationParams), height: 100, width: width)
          ],
        ),),
      ),
    );
  }

  // From Native
  Widget _getName(Map<String, dynamic> creationParams) {
    const String viewType = 'get-name';
    return _getNativeView(creationParams, viewType);
  }

  // From/To Flutter
  Widget _getAgeDisplayName(String name) {
    return TrygComponent1(
      name: name,
      callback: (v) {
        print('Callback med info ${v}');
      },
    );
  }

  // To Native
  Widget _displayNameAndAge(Map<String, dynamic> creationParams) {
    const String viewType = 'get-name';
    return _getNativeView(creationParams, viewType);
  }


  Widget _getNativeView(Map<String, dynamic> creationParams, String viewType) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return Text("On Android");
      case TargetPlatform.iOS:
        return _getIOSWidget(viewType, creationParams);
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }

  Widget _getIOSWidget(String viewType, Map<String, dynamic> creationParams) {
    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }


}