import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tryg_poc_component1/tryg_poc_component1.dart';

import '../widgets/native_view_.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        _pressureReading = 0;
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
                  child: NativeViewExample(
                    viewType: '<platform-view-type>',
                    creationParams: creationParams,
                  )),

              //Container(child: _getName(creationParams), height: 100, width: width),
              TrygComponent1(
                name: "Peter Petersen",
                callback: (v) => print('Callback med info $v'),
              ),
              Text('sensor reading $_sensorAvailable'),
              ElevatedButton(
                  onPressed: () => _checkAvailableAsync(), child: const Text('isReady?')),
              Text('sensor reading $_pressureReading'),
              ElevatedButton(
                  onPressed: () => _startReading(), child: const Text('start')),
              SizedBox(
                  height: 400,
                  width: width,
                  child: NativeViewExample(
                    viewType: '<platform-view-type>',
                    creationParams: creationParams,
                  )),
            ],
          ),
        ),
      ),
    );
  }

}
