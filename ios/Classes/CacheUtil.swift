//
//  CacheUtil.swift
//  ivs_player
//
//  Created by Utkarsh Sharma on 09/03/23.
//

import Foundation
import AmazonIVSPlayer


class CacheUtil {
    //Singleton Class for maintaining cache at native side.
    static let i = CacheUtil()
    private init(){}
    
     private var maxInstanceCount: Int = 5
     private var playerCache: [Int32:IVSPlayerView]=[:]
    
     func getPlayerView(key:Int32) -> IVSPlayerView? {
        return playerCache[key]
    }
    
     func setPlayerView(key:Int32,playerInstance:IVSPlayerView) {
        playerCache[key] = playerInstance
    }
    
    func removePlayer(key:Int32){
        playerCache.removeValue(forKey: key)
    }
}

