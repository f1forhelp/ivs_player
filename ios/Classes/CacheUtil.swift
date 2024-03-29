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
     private var playerCache: [Int32:IvsPlayer]=[:]
    
     func getPlayer(key:Int32) -> IvsPlayer? {
        return playerCache[key]
    }
    
     func setPlayer(key:Int32,playerInstance:IvsPlayer) {
        playerCache[key] = playerInstance
    }
    
    func removePlayer(key:Int32){
        print(getPlayer(key: key))
        playerCache.removeValue(forKey: key)
        print(getPlayer(key: key))
    }
}

