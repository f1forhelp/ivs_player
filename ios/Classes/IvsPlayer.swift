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


class IvsPlayer: NSObject , FlutterPlatformView,IvsPlayerApi{
    func create() throws -> Int64? {
        return 0
    }
    
    func view() -> UIView {
        return ivsPlayerView
    }
    
    var viewId: Int32
    private let streamChannel:FlutterEventChannel
    var playerStateEventSink: FlutterEventSink?
    let ivsPlayerView:IVSPlayerView
    

    init(
        binaryMessenger messenger: FlutterBinaryMessenger,
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) {
        self.viewId = Int32(exactly: viewId) ?? 0
        ivsPlayerView = IVSPlayerView()
        ivsPlayerView.player = IVSPlayer()
        streamChannel = FlutterEventChannel(name: "EventChannelPlayerIvs_id=\(self.viewId)", binaryMessenger: messenger)
        super.init()
//        pixelBuffer = convertUIViewToPixelBuffer(view: ivsPlayerView)
        ivsPlayerView.player?.delegate =  self
        CacheUtil.i.setPlayer(key:self.viewId, playerInstance: self)
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
    
    let playerView :IvsPlayer
    
    init(playerView :IvsPlayer) {
        self.playerView = playerView
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        return playerView.onListenPlayerState(withArguments: arguments, eventSink: events)
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return playerView.onCancelPlayerState(withArguments: arguments)
    }
}
