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
import android.content.Context
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.net.Uri
import android.provider.CalendarContract.Colors
import android.util.Log
import android.view.View
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.TextView
import androidx.core.content.ContextCompat
import com.amazonaws.ivs.player.*
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.platform.PlatformView
import java.nio.ByteBuffer
import kotlin.math.roundToLong

internal class FlutterIvsPlayerView(context: Context, viewId: Long, creationParams: Map<String?, Any?>?, messenger: BinaryMessenger) : PlatformView,IvsPlayerApi {

    var viewId:Long
    private var streamChannel:EventChannel
    private var eventSink:EventSink? = null
//    private val textView: TextView

    override fun getView(): View {
        return CacheUtil.getPlayerView(viewId)?.rootView!!
    }

    override fun dispose() {}

    init {
        this.viewId = viewId
        val ivsPlayer:PlayerView = PlayerView(context)

//        ivsPlayer.setBackgroundColor(ContextCompat.getColor(context, android.R.color.transparent))
        ivsPlayer.controlsEnabled = false;
        ivsPlayer.controls.showControls(false)
        IvsPlayerApi.setUp(messenger,this)
        streamChannel = EventChannel( messenger,"EventChannelPlayerIvs")
        streamChannel.setStreamHandler(object : StreamHandler{

            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
            }

            override fun onCancel(arguments: Any?) {
                TODO("Not yet implemented")
            }

        })
        CacheUtil.setPlayerView(this.viewId, ivsPlayer)
        handlePlayerEvents()
//        Player player = playerView.getPlayer();
//// Set up to receive playback events and errors
//        player.addListener(this);
//        textView = TextView(context)
//        textView.textSize = 72f
//        textView.setBackgroundColor(Color.rgb(255, 255, 255))
//        textView.text = "Rendered on a native Android view (id: $id)"
    }






    private fun handlePlayerEvents() {
        CacheUtil.getPlayerView(viewId)?.player?.apply {
            // Listen to changes on the player
            addListener(object : Player.Listener() {
                override fun onAnalyticsEvent(p0: String, p1: String) {}
                override fun onDurationChanged(p0: Long) {
                    fun data(v:Double,id:Int) :String{
                        return """
                        {"duration":{"value":$v,"viewId":$id}}
                        """;
                    }
                    eventSink?.success(data(((p0/1000).toDouble()),viewId.toInt()))
//                    // If the video is a VOD, you can seek to a duration in the video
//                    Log.i("IVSPlayer", "New duration: $duration")
//                    seekTo(p0)
                }

                override fun onError(p0: PlayerException) {
                    fun data(v:String,id:Int) :String{
                        return """
                        {"error":{"value":$v,"viewId":$id}}
                        """;
                    }
                    eventSink?.success(data(p0.toString(),viewId.toInt()))
                }
                override fun onMetadata(type: String, data: ByteBuffer) {}
                override fun onQualityChanged(p0: Quality) {
                    fun data(w:Int,h:Int,name:String,id:Int) :String{
                        return """
                       {"quality":{"width":$w,"height":$h,"name":"$name","viewId":$id}}
                        """;
                    }
                    eventSink?.success(data(p0.width,p0.height,p0.name,viewId.toInt()))
                }

                override fun onRebuffering() {}
                override fun onSeekCompleted(p0: Long) {}
                override fun onVideoSizeChanged(p0: Int, p1: Int) {}
                override fun onCue(cue: Cue) {
//                    when (cue) {
//                        is TextMetadataCue -> Log.i("IVSPlayer","Received Text Metadata: ${cue.text}")
//                    }
                }

                override fun onStateChanged(state: Player.State) {
                    fun data(v:Int,id:Int) :String{
                        return """
                            {"state":{"value":$v,"viewId":$id}}
                        """;
                    }

                    when (state) {
                        Player.State.BUFFERING -> {
                            eventSink?.success(data(4,viewId.toInt()))
                        }
                        Player.State.READY -> {
                            eventSink?.success(data(1,viewId.toInt()))
                        }
                        Player.State.IDLE -> {
                            eventSink?.success(data(2,viewId.toInt()))
                        }
                        Player.State.ENDED -> {
                            eventSink?.success(data(5,viewId.toInt()))
                        }
                        Player.State.PLAYING -> {
                            eventSink?.success(data(3,viewId.toInt()))
                            // Qualities will be dependent on the video loaded, and can
                            // be retrieved from the player
                        }
                    }
                }
            })
        }
    }


    override fun autoQualityMode(mode: AutoQualityModeMessage): Boolean {
        val p = CacheUtil.getPlayerView( mode.viewId)?.player
        return if(mode.autoQualityMode != null){
            p?.isAutoQualityMode = mode.autoQualityMode
            mode.autoQualityMode
        }else{
            p?.isAutoQualityMode ?: true
        }
    }


    //TODO: talk to amazon to make a setter for the same.
    override fun looping(loopingMessage: LoopingMessage): Boolean {
        val p = CacheUtil.getPlayerView( loopingMessage.viewId)?.player
        return if(loopingMessage.looping != null){
            p?.setLooping(loopingMessage.looping)
            loopingMessage.looping
        }else{
            false;
        }
    }

    override fun mute(mutedMessage: MutedMessage): Boolean {
        val p = CacheUtil.getPlayerView( mutedMessage.viewId)?.player
        if(mutedMessage.muted != null){
            p?.isMuted = mutedMessage.muted
            return mutedMessage.muted
        }else{
            return  p?.isMuted ?: false
        }
    }

    override fun playbackRate(playbackRateMessage: PlaybackRateMessage): Double {
        val p = CacheUtil.getPlayerView( playbackRateMessage.viewId)?.player
        if(playbackRateMessage.playbackRate != null){
            p?.playbackRate = (playbackRateMessage.playbackRate).toFloat()
            return playbackRateMessage.playbackRate
        }else{
            return  p?.playbackRate?.toDouble() ?: 0.0
        }
    }

    override fun volume(volumeMessage: VolumeMessage): Double {
        val p = CacheUtil.getPlayerView( volumeMessage.viewId)?.player
        if(volumeMessage.volume != null){
            p?.volume = (volumeMessage.volume).toFloat()
            return volumeMessage.volume
        }else{
            return  p?.volume?.toDouble() ?: 0.0
        }
    }

    override fun videoDuration(viewMessage: ViewMessage): Double {
        val p = CacheUtil.getPlayerView( viewMessage.viewId)?.player
        return p?.duration?.toDouble() ?: 0.0
    }

    override fun playbackPosition(viewMessage: ViewMessage): Double {
        return CacheUtil.getPlayerView( viewMessage.viewId)?.player?.position?.toDouble() ?: 0.0
    }

    override fun qualities(viewMessage: ViewMessage): List<FQuality> {
        val q = CacheUtil.getPlayerView( viewMessage.viewId)?.player?.qualities?.toList() ?: emptyList()
        val qualities = mutableListOf<FQuality>()
        for (quality: Quality in q){
            qualities.add(FQuality(quality.name,quality.height.toLong(),quality.width.toLong()))
        }
        return qualities
    }

    override fun quality(qualityMessage: FQualityMessage): FQuality {
        val p = CacheUtil.getPlayerView( qualityMessage.viewId)?.player
        if(qualityMessage.quality != null){

            for (quality: Quality in p?.qualities?.toList() ?: emptyList()){
                if(quality.name == qualityMessage.quality.name){
                    p?.quality = quality
                    break
                }
            }
        }
        val q = p?.quality
        return   FQuality( q?.name ?: "", q?.height?.toLong() ?: 0, q?.width?.toLong() ?: 0)
    }

    override fun pause(viewMessage: ViewMessage) {
        CacheUtil.getPlayerView( viewMessage.viewId)?.player?.pause()
    }

    override fun load(loadMessage: LoadMessage) {
            CacheUtil.getPlayerView( loadMessage.viewId)?.player?.load(Uri.parse(loadMessage.url))
    }

    override fun play(viewMessage: ViewMessage) {
            CacheUtil.getPlayerView( viewMessage.viewId)?.player?.play()
    }

    override fun seekTo(seekMessage: SeekMessage) {
        io.flutter.Log.d("DURATION_SENT","${seekMessage.seconds*1000}")
        CacheUtil.getPlayerView( seekMessage.viewId)?.player?.seekTo((seekMessage.seconds*1000).roundToLong())
//        CacheUtil.getPlayerView( seekMessage.viewId)?.player?.seekTo(1000*120)
    }

    override fun dispose(viewMessage: ViewMessage) {
        CacheUtil.getPlayerView( viewMessage.viewId)?.player?.release()
        CacheUtil.removePlayer( viewMessage.viewId)
    }
}