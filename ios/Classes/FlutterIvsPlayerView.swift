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
//    private var _nativeWebView: UIWebView
    private var _ivsPlayerView: IVSPlayerView
//    private var _streamChannel: FlutterEventChannel
    
    func view() -> UIView {
        playVideo(url: URL(string: "https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8")!)

        return _ivsPlayerView
    }
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
//        _streamChannel = FlutterMethodChannel(name: "plugins.codingwithtashi/flutter_web_view_\(viewId)", binaryMessenger: messenger)
//        _streamChannel = FlutterEventChannel(name:IVSConstants.channelId, binaryMessenger: messenger)
        _ivsPlayerView = IVSPlayerView()
        
//        _streamChannel.setMethodCallHandler(onMethodCall)
//        _streamChannel.setStreamHandler(<#T##handler: (FlutterStreamHandler & NSObjectProtocol)?##(FlutterStreamHandler & NSObjectProtocol)?#>)
        super.init()
    }
    
//    func onMethodCall(call: FlutterMethodCall, result: FlutterResult) {
//          switch(call.method){
//          case "setUrl":
//              setText(call:call, result:result)
//          default:
//              result(FlutterMethodNotImplemented)
//          }
//      }
    
    
    func playVideo(url videoURL: URL) {
            let player = IVSPlayer()
            player.delegate = self
        _ivsPlayerView.player = player
            player.load(videoURL)
    }
}


extension FlutterIvsPlayerView: IVSPlayer.Delegate {
    func player(_ player: IVSPlayer, didChangeState state: IVSPlayer.State) {
        if state == .ready {
            player.play()
        }
    }
}
