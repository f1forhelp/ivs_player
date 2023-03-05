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
    private var _methodChannelPlayer: FlutterMethodChannel
    private var _ivsPlayer:IVSPlayer
//    private var _streamChannel: FlutterEventChannel
    
    func view() -> UIView {
//        playVideo(url: URL(string: "https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8")!)
//        _ivsPlayer = IVSPlayer()
//        _ivsPlayerView = IVSPlayerView()
        _ivsPlayerView.player = _ivsPlayer;
        return _ivsPlayerView
    }
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        _ivsPlayerView = IVSPlayerView()
        _ivsPlayer = IVSPlayer()
        
        let urla = "\(IVSConstants.viewTypeIvsPlayer)_\(viewId)"
        _methodChannelPlayer = FlutterMethodChannel(name:urla, binaryMessenger: messenger)
        print(urla)

        super.init()
        _ivsPlayer.delegate = self
        _methodChannelPlayer.setMethodCallHandler(onMethodCall)
    }
    
    func onMethodCall(call: FlutterMethodCall, result: FlutterResult) {
       let args = call.arguments
        
        switch(call.method){
        case "autoQualityMode-s":
            _ivsPlayer.autoQualityMode = (args as? Bool) ?? true
            result(nil)
        case "autoQualityMode-g":
            result(_ivsPlayer.autoQualityMode)
        case "looping-s":
            _ivsPlayer.looping = (args as? Bool) ?? true
            result(nil)
        case "looping-g":
            result(_ivsPlayer.looping)
        
       
//        case "play":
//            _ivsPlayer.play();
        case "load":
            if(args != nil){
                let url = args as! String
                _ivsPlayer.load(URL(string: url));
                result(nil)
            }
            
        case "play":
            _ivsPlayer.play()
            result(nil)
        case "enable_pip":
            if #available(iOS 15.0, *) {
                let pip = AVPictureInPictureController(ivsPlayerLayer: _ivsPlayerView.playerLayer)
                
                pip?.startPictureInPicture();
                print( AVPictureInPictureController(ivsPlayerLayer: _ivsPlayerView.playerLayer))
                print(_ivsPlayerView.playerLayer)
                print(pip)
                print(pip?.isPictureInPicturePossible)
                print(pip?.isPictureInPictureActive)
                print(pip?.isPictureInPictureSuspended)
                result(nil)
            } else {
                // Fallback on earlier versions
            }

          default:
              result(FlutterMethodNotImplemented)
          }
      }
    
    
    func playVideo(url videoURL: URL) {
            let player = IVSPlayer()
            player.delegate = self
        _ivsPlayerView.player = player
            player.load(videoURL)
    }
}


extension FlutterIvsPlayerView: IVSPlayer.Delegate {
    func player(_ player: IVSPlayer, didChangeState state: IVSPlayer.State) {
        print(state);
        if state == .ready {
//            player.play()
        }

    }
}

