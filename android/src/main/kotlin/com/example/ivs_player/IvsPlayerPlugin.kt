package com.example.ivs_player

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
/** IvsPlayerPlugin */
class IvsPlayerPlugin: FlutterPlugin {

  override fun onAttachedToEngine(binding: FlutterPluginBinding) {
    binding
      .platformViewRegistry
      .registerViewFactory(IVSConstants.viewTypeIvsPlayer, FLNativeViewFactory(binding.binaryMessenger))
  }

  override fun onDetachedFromEngine(binding: FlutterPluginBinding) {}
}


class FLNativeViewFactory(private val messenger:BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
  override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
    val creationParams = args as Map<String?, Any?>?
//    return  FlutterWebView(context,messenger,viewId)
    return FlutterIvsPlayerView(context, viewId.toLong(), creationParams,messenger)
  }
}