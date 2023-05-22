package com.example.ivs_player

import AutoQualityModeMessage
import FQuality
import FQualityMessage
import IvsPlayerApi
import LoadMessage
import LoopingMessage
import MutedMessage
import PlaybackRateMessage
import SeekMessage
import ViewMessage
import VolumeMessage
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.view.TextureRegistry

/** IvsPlayerPlugin */
class IvsPlayerPlugin: FlutterPlugin,IvsPlayerApi {

  private lateinit var flutterState:FlutterState


  private lateinit var streamChannel: EventChannel
  private  var eventSink: EventSink? = null

  override fun onAttachedToEngine(binding: FlutterPluginBinding) {
    flutterState = FlutterState(
      binding.applicationContext,
      binding.binaryMessenger,
      binding.textureRegistry
    )
    flutterState.startListening(this,binding.binaryMessenger)

  }

  override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
    flutterState.stopListening(binding.binaryMessenger);
  }
  override fun autoQualityMode(mode: AutoQualityModeMessage): Boolean {
   return CacheUtil.getPlayer(mode.viewId)?.autoQualityMode(mode) ?: true
  }

  override fun looping(loopingMessage: LoopingMessage): Boolean {
    return CacheUtil.getPlayer(loopingMessage.viewId)?.looping(loopingMessage) ?: true
  }

  override fun mute(mutedMessage: MutedMessage): Boolean {
    return CacheUtil.getPlayer(mutedMessage.viewId)?.mute(mutedMessage) ?: true
  }

  override fun playbackRate(playbackRateMessage: PlaybackRateMessage): Double {
    return CacheUtil.getPlayer(playbackRateMessage.viewId)?.playbackRate(playbackRateMessage) ?: 0.0
  }

  override fun volume(volumeMessage: VolumeMessage): Double {
    return CacheUtil.getPlayer(volumeMessage.viewId)?.volume(volumeMessage) ?: 0.0
  }

  override fun videoDuration(viewMessage: ViewMessage): Double {
    return CacheUtil.getPlayer(viewMessage.viewId)?.videoDuration(viewMessage) ?: 0.0
  }

  override fun playbackPosition(viewMessage: ViewMessage): Double {
    return CacheUtil.getPlayer(viewMessage.viewId)?.playbackPosition(viewMessage) ?: 0.0
  }

  override fun qualities(viewMessage: ViewMessage): List<FQuality> {
    return CacheUtil.getPlayer(viewMessage.viewId)?.qualities(viewMessage) ?: emptyList()
  }

  override fun quality(qualityMessage: FQualityMessage): FQuality {
    return CacheUtil.getPlayer(qualityMessage.viewId)?.quality(qualityMessage) ?: FQuality(  "",0, 0)
  }

  override fun create(): Long {
    val texture = flutterState.textureRegistry.createSurfaceTexture();
    CacheUtil.setPlayer(texture.id() ?: 0,IvsPlayer(flutterState.context,texture,flutterState.binaryMessenger));
    return  texture.id()
  }


  override fun pause(viewMessage: ViewMessage) {
    CacheUtil.getPlayer(viewMessage.viewId)?.pause(viewMessage)
  }

  override fun load(loadMessage: LoadMessage) {
    CacheUtil.getPlayer(loadMessage.viewId)?.load(loadMessage)
  }

  override fun play(viewMessage: ViewMessage) {
    CacheUtil.getPlayer(viewMessage.viewId)?.play(viewMessage)
  }

  override fun seekTo(seekMessage: SeekMessage) {
    CacheUtil.getPlayer(seekMessage.viewId)?.seekTo(seekMessage)
  }

  override fun dispose(viewMessage: ViewMessage) {
    CacheUtil.getPlayer(viewMessage.viewId)?.dispose()
    CacheUtil.removePlayer(viewMessage.viewId)
  }
}

class FlutterState(val context: Context,val binaryMessenger: BinaryMessenger,val textureRegistry: TextureRegistry){
  fun startListening(ivsPlayerPlugin: IvsPlayerPlugin, binaryMessenger: BinaryMessenger): Unit {
    IvsPlayerApi.setUp(binaryMessenger,ivsPlayerPlugin)
  }

  fun stopListening( binaryMessenger: BinaryMessenger): Unit {
    IvsPlayerApi.setUp(binaryMessenger,null)
  }
}