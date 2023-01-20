import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class NativeView extends StatelessWidget {
  final String viewType;
  final Map<String, dynamic> creationParams;

  NativeView({super.key, required this.viewType, required this.creationParams});
  
  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _NativeAndroidView(viewType, creationParams);
      case TargetPlatform.iOS:
        return _NativeIOSView(viewType, creationParams);
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }
}

class _NativeAndroidView extends StatelessWidget {
  final String viewType;
  final Map<String, dynamic> creationParams;

  const _NativeAndroidView(
       this.viewType, this.creationParams);

  @override
  Widget build(BuildContext context) {
    return PlatformViewLink(
      viewType: viewType,
      surfaceFactory: (context, controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (params) {
        return PlatformViewsService.initSurfaceAndroidView(
          id: params.id,
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
          onFocus: () {
            params.onFocusChanged(true);
          },
        )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..create();
      },
    );
  }
}

class _NativeIOSView extends StatelessWidget{
  final String viewType;
  final Map<String, dynamic> creationParams;

  const _NativeIOSView(
      this.viewType,  this.creationParams);
  
  @override
  Widget build(BuildContext context) {
    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
  
}
