//
//  FlutterIvsPlayer.swift
//  amazon_ivs
//
//  Created by Utkarsh Sharma on 23/02/23.
//

import Foundation
import Flutter
import UIKit
import AVKit
import AmazonIVSPlayer



class FlutterIvsPlayerView: NSObject, FlutterPlatformView  {

    private var viewId: Int32
    
    func view() -> UIView {
        return CacheUtil.i.getPlayerView(key: viewId)!
    }
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        self.viewId = Int32(exactly: viewId) ?? 0
        let ivsPlayer = IVSPlayerView()
        ivsPlayer.player = IVSPlayer()
        super.init()
//        ivsPlayer.player?.delegate =  self
        
        CacheUtil.i.setPlayerView(key:self.viewId, playerInstance: ivsPlayer)

        IvsPlayerApiSetup.setUp(binaryMessenger: messenger, api: self)
    }
    
}


//extension FlutterIvsPlayerView: IVSPlayer.Delegate {
//    func player(_ player: IVSPlayer, didChangeState state: IVSPlayer.State) {
//        print(state);
//        if state == .ready {
//            print("STATE IS : ready");
////            player.play()
//        }
//        if state == .playing {
//            print("STATE IS : playing");
////            player.play()
//        }
//        if state == .idle {
//            print("STATE IS : idle");
////            player.play()
//        }
//
//    }
//}
