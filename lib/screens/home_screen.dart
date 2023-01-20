import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tryg_poc_component1/tryg_poc_component1.dart';

import '../widgets/native_view_.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const methodChannel = MethodChannel('barometer/method');
  static const pressureChannel = EventChannel('barometer/pressure');

  String _sensorAvailable = 'Unknown';
  double _pressureReading = 0;
  late StreamSubscription pressureSubscription;

  Future<void> _checkAvailableAsync() async {
    try {
      var result = await methodChannel.invokeMethod('isSensorAvailable');
      setState(() {
        _sensorAvailable = result.toString();
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  _startReading() {
    pressureSubscription =
        pressureChannel.receiveBroadcastStream().listen((event) {
      setState(() {
        _pressureReading = event;
      });
    });
  }

  _stopReading() {
    setState(() {
      _pressureReading = 0;
    });
    pressureSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    const Map<String, dynamic> creationParams = <String, dynamic>{
      "a": "Click on me!"
    };
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("TRYG forsikrings app"),
              SizedBox(
                  height: 400,
                  width: width,
                  child: NativeView(
                    viewType: '<platform-view-type>',
                    creationParams: creationParams,
                  )),
              TrygComponent1(
                name: "Peter Petersen",
                callback: (v) => print('Callback med info $v'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
