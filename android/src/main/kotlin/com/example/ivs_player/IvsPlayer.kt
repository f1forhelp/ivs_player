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
import android.net.Uri
import android.view.Surface
import com.amazonaws.ivs.player.*
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.view.TextureRegistry
import java.nio.ByteBuffer
import kotlin.math.roundToLong

class IvsPlayer(context: Context,textureRegistry: TextureRegistry.SurfaceTextureEntry,binaryMessenger: BinaryMessenger) {

    var viewId:Long
    private lateinit var ivsPlayer:Player
    private var streamChannel:EventChannel
    private var eventSink:EventSink? = null
    lateinit var surface: Surface;
    lateinit var textureRegistry: TextureRegistry.SurfaceTextureEntry
//    private val textView: TextView

//    override fun getView(): View {
//        return CacheUtil.getPlayerView(viewId)?.rootView!!
//    }
//
//    override fun dispose() {}

    init {
        this.textureRegistry = textureRegistry
        this.viewId = textureRegistry.id()
        val ivsPlayerView:PlayerView = PlayerView(context)

        surface =Surface(textureRegistry.surfaceTexture())
        ivsPlayerView.player.setSurface(surface)

//        ivsPlayer.setBackgroundColor(ContextCompat.getColor(context, android.R.color.transparent))
        ivsPlayerView.controlsEnabled = false;
        ivsPlayerView.controls.showControls(false)
//        val medi:MediaPlayer = MediaPlayer(context)

        this.ivsPlayer = ivsPlayerView.player;
        streamChannel = EventChannel( binaryMessenger,"EventChannelPlayerIvs")
        streamChannel.setStreamHandler(object : StreamHandler{

            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
            }

            override fun onCancel(arguments: Any?) {
                TODO("Not yet implemented")
            }

        })
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
        ivsPlayer.apply {
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
                        {"error":{"value":"${v.toString()}","viewId":$id}}
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


     fun autoQualityMode(mode: AutoQualityModeMessage): Boolean {

        return if(mode.autoQualityMode != null){
            ivsPlayer.isAutoQualityMode = mode.autoQualityMode
            mode.autoQualityMode
        }else{
            ivsPlayer.isAutoQualityMode ?: true
        }
    }


    //TODO: talk to amazon to make a setter for the same.
     fun looping(loopingMessage: LoopingMessage): Boolean {
        return if(loopingMessage.looping != null){
            ivsPlayer.setLooping(loopingMessage.looping)
            loopingMessage.looping
        }else{
            false;
        }
    }

     fun mute(mutedMessage: MutedMessage): Boolean {
        return if(mutedMessage.muted != null){
            ivsPlayer.isMuted = mutedMessage.muted
            mutedMessage.muted
        }else{
            ivsPlayer.isMuted ?: false
        }
    }

     fun playbackRate(playbackRateMessage: PlaybackRateMessage): Double {
        return if(playbackRateMessage.playbackRate != null){
            ivsPlayer.playbackRate = (playbackRateMessage.playbackRate).toFloat()
            playbackRateMessage.playbackRate
        }else{
            ivsPlayer.playbackRate.toDouble() ?: 0.0
        }
    }

     fun volume(volumeMessage: VolumeMessage): Double {
        return if(volumeMessage.volume != null){
            ivsPlayer.volume = (volumeMessage.volume).toFloat()
            volumeMessage.volume
        }else{
            ivsPlayer.volume.toDouble() ?: 0.0
        }
    }

     fun videoDuration(viewMessage: ViewMessage): Double {
        return ivsPlayer.duration.toDouble() ?: 0.0
    }

     fun playbackPosition(viewMessage: ViewMessage): Double {
        return ivsPlayer.position.toDouble() ?: 0.0
    }

     fun qualities(viewMessage: ViewMessage): List<FQuality> {
        val q = ivsPlayer.qualities.toList() ?: emptyList()
        val qualities = mutableListOf<FQuality>()
        for (quality: Quality in q){
            qualities.add(FQuality(quality.name,quality.height.toLong(),quality.width.toLong()))
        }
        return qualities
    }

     fun quality(qualityMessage: FQualityMessage): FQuality {
        if(qualityMessage.quality != null){

            for (quality: Quality in ivsPlayer.qualities.toList() ?: emptyList()){
                if(quality.name == qualityMessage.quality.name){
                    ivsPlayer.quality = quality
                    break
                }
            }
        }
        val q = ivsPlayer.quality
        return   FQuality( q.name ?: "", q.height.toLong() ?: 0, q.width.toLong() ?: 0)
    }

     fun pause(viewMessage: ViewMessage) {
        ivsPlayer.pause()
    }

     fun load(loadMessage: LoadMessage) {
        ivsPlayer.load(Uri.parse(loadMessage.url))
    }

     fun play(viewMessage: ViewMessage) {
        ivsPlayer.play()
    }

     fun seekTo(seekMessage: SeekMessage) {
        ivsPlayer.seekTo((seekMessage.seconds*1000).roundToLong())
//        CacheUtil.getPlayerView( seekMessage.viewId)?.player?.seekTo(1000*120)
    }

    fun dispose(){

//        ivsPlayer.removeListener(ivsPlayer)
        ivsPlayer.release();
        surface.release();
        textureRegistry.release();
        
    }

}