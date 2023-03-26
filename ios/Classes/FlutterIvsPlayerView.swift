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

    private var viewId: Int32
    private let streamChannel:FlutterEventChannel
    private var playerStateEventSink: FlutterEventSink?
    
    
    
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
        events("Noobita")
        return playerView.onListenPlayerState(withArguments: arguments, eventSink: events)
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return playerView.onCancelPlayerState(withArguments: arguments)
    }
}


extension FlutterIvsPlayerView: IVSPlayer.Delegate {
    func player(_ player: IVSPlayer, didChangeState state: IVSPlayer.State) {
        print(state);
        if state == .ready {
            playerStateEventSink?("Ready")
//            streamChannel/
            print("STATE IS : ready");
//            player.play()
        }
        if state == .playing {
            playerStateEventSink?("Playing")
            print("STATE IS : playing");
//            player.play()
        }
        if state == .idle {
            playerStateEventSink?("Idle")
            print("STATE IS : idle");
//            player.play()
        }

    }
}
