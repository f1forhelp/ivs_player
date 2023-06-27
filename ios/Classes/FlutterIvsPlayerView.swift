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



class FlutterIvsPlayerView: NSObject, FlutterPlatformView {

    var viewId: Int32
    private let streamChannel:FlutterEventChannel
    var playerStateEventSink: FlutterEventSink?
    
    let ivsPlayer:IVSPlayerView
    
    
    func view() -> UIView {
        return ivsPlayer
//        return CacheUtil.i.getPlayerView(key: viewId)!
    }
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        self.viewId = Int32(exactly: viewId) ?? 0
        ivsPlayer = IVSPlayerView(frame:frame)
        ivsPlayer.player = IVSPlayer()
        streamChannel = FlutterEventChannel(name: "EventChannelPlayerIvs", binaryMessenger: messenger)
        super.init()
        ivsPlayer.player?.delegate =  self
        CacheUtil.i.setPlayerView(key:self.viewId, playerInstance: ivsPlayer)
        IvsPlayerApiSetup.setUp(binaryMessenger: messenger, api: self)
        streamChannel.setStreamHandler(PlayerStreamHandler(playerView: self))
    }
    
    func onListenPlayerState(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        playerStateEventSink = events
        return nil
    }
    
    func onCancelPlayerState(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
}


class PlayerStreamHandler: NSObject,FlutterStreamHandler{
    
    let playerView :FlutterIvsPlayerView
    
    init(playerView :FlutterIvsPlayerView) {
        self.playerView = playerView
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        return playerView.onListenPlayerState(withArguments: arguments, eventSink: events)
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return playerView.onCancelPlayerState(withArguments: arguments)
    }
}





/// Total duration of the loaded media stream.
///
/// This property is key-value observable.
/// @see `-[IVSPlayerDelegate player:didChangeDuration]`

//extension FlutterIvsPlayerView{
//    func player(_ player: IVSPlayer, didChangeDuration state: IVSPlayer.State) {
//        print("TOTAL-P:\(state)")
//    }
//}

///// Fatal error encountered during playback.
/////
///// This property is key-value observable.
///// @see `-[IVSPlayerDelegate player:didFailWithError:]`
//@property (nonatomic, readonly, nullable) NSError *error;
//extension FlutterIvsPlayerView{
//    func errorIs(_ player: IVSPlayer, didFailWithError state: IVSPlayer.State) {
//        switch (state){
//        case .ready:
//                self.playerStateEventSink?(1)
//        case .idle:
//                self.playerStateEventSink?(2)
//        case .playing:
//                self.playerStateEventSink?(3)
//        case .buffering:
//                self.playerStateEventSink?(4)
//        case .ended:
//                self.playerStateEventSink?(5)
//        default:
//            self.playerStateEventSink?(-1)
//        }
//    }
//}
