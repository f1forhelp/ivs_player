package com.example.ivs_player

import android.content.Context
import com.amazonaws.ivs.player.PlayerView
import io.flutter.view.TextureRegistry
import io.flutter.view.TextureRegistry.SurfaceTextureEntry


object CacheUtil {
    //Singleton Class for maintaining cache at native side.
//    static let i = CacheUtil()
//    private init(){}
//
    private var maxInstanceCount: Int = 5
    private var playerCache = HashMap<Long,IvsPlayer >()
//
    fun getPlayer(key:Long): IvsPlayer? {
        return playerCache[key]
    }


    fun setPlayer(key:Long,playerInstance:IvsPlayer) {
        playerCache[key] = playerInstance
    }

    fun removePlayer(key:Long){
//        playerCache[key]?.player?.removeListener(ivsPlayerView)
        playerCache.remove(key)
    }
}

class CacheModel{
    lateinit var ivsPlayer: IvsPlayer
    lateinit var surfaceTextureEntry: TextureRegistry.SurfaceTextureEntry
}