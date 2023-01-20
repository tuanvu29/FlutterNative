package com.example.tryg_poc_native

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding

class PlatformViewPlugin : FlutterPlugin {
    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        binding
            .platformViewRegistry
            .registerViewFactory("<platform-view-type>", NativeViewFactory(buttonChannel))
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {}
}