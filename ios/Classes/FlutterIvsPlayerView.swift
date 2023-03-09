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


class FlutterIvsPlayerView: NSObject, FlutterPlatformView , IvsPlayerApi {

    private var _ivsPlayerView: IVSPlayerView
    private var _ivsPlayer:IVSPlayer

    func view() -> UIView {
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
        
        super.init()
        IvsPlayerApiSetup.setUp(binaryMessenger: messenger, api: self)
        _ivsPlayer.delegate = self
    }
    
    func pause() throws {
        return _ivsPlayer.pause()
    }
    
    func load(url: String) throws {
        return _ivsPlayer.load(URL(string: url));
    }
    
    func play() throws {
        return _ivsPlayer.play()
    }
    
    
    
//    func onMethodCall(call: FlutterMethodCall, result: FlutterResult) {
//       let args = call.arguments
//
//        switch(call.method){
//        case "autoQualityMode-s":
//            _ivsPlayer.autoQualityMode = (args as? Bool) ?? true
//            result(nil)
//        case "autoQualityMode-g":
//            result(_ivsPlayer.autoQualityMode)
//        case "looping-s":
//            _ivsPlayer.looping = (args as? Bool) ?? true
//            result(nil)
//        case "looping-g":
//            result(_ivsPlayer.looping)
//
//
////        case "play":
////            _ivsPlayer.play();
//        case "load":
//            if(args != nil){
//                let url = args as! String
//                _ivsPlayer.load(URL(string: url));
//                result(nil)
//            }
//
//        case "play":
//            _ivsPlayer.play()
//            result(nil)
//        case "enable_pip":
//            if #available(iOS 15.0, *) {
//                let pip = AVPictureInPictureController(ivsPlayerLayer: _ivsPlayerView.playerLayer)
//
//                pip?.startPictureInPicture();
//                result(nil)
//            } else {
//                // Fallback on earlier versions
//            }
//
//          default:
//              result(FlutterMethodNotImplemented)
//          }
//      }
}


extension FlutterIvsPlayerView: IVSPlayer.Delegate {
    func player(_ player: IVSPlayer, didChangeState state: IVSPlayer.State) {
        print(state);
        if state == .ready {
//            player.play()
        }

    }
}

