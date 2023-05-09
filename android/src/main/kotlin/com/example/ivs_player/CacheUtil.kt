package com.example.ivs_player

import android.content.Context
import com.amazonaws.ivs.player.PlayerView


object CacheUtil {
    //Singleton Class for maintaining cache at native side.
//    static let i = CacheUtil()
//    private init(){}
//
    private var maxInstanceCount: Int = 5
    private var playerCache = HashMap<Long,PlayerView >()
//
    fun getPlayerView(key:Long): PlayerView? {
        return playerCache[key]
    }


    fun setPlayerView(key:Long,playerInstance:PlayerView) {
        playerCache[key] = playerInstance
    }

    fun removePlayer(key:Long){
//        playerCache[key]?.player?.removeListener(ivsPlayerView)
        playerCache.remove(key)
    }
}
