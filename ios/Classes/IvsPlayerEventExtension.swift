//
//  IvsPlayerEventExtension.swift
//  ivs_player
//
//  Created by Utkarsh Sharma on 26/03/23.
//

import Foundation
import AmazonIVSPlayer

/// The state of the player.
///
/// This property is key-value observable.
/// @see `-[IVSPlayerDelegate player:didChangeState:]`
extension FlutterIvsPlayerView{
    func player(_ player: IVSPlayer, didChangeState state: IVSPlayer.State) {
        func data (v:Int,id:Int32) -> String{
            return """
                {"state":{"value":\(v),"viewId":\(id)}}
            """;
        }
        
        switch (state){
        case .ready:
            self.playerStateEventSink?(data(v: 1,id:viewId))
        case .idle:
            self.playerStateEventSink?(data(v: 2,id:viewId))
        case .playing:
            self.playerStateEventSink?(data(v: 3,id:viewId))
        case .buffering:
            self.playerStateEventSink?(data(v: 4,id:viewId))
        case .ended:
            self.playerStateEventSink?(data(v: 5,id:viewId))
        default:
            self.playerStateEventSink?(data(v: -1,id:viewId))
        }
    }
}

extension FlutterIvsPlayerView:IVSPlayer.Delegate {
    func player(_ player: IVSPlayer, didChangeDuration duration:AmazonIVSPlayer.CMTime) {
        func data (v:Double,id:Int32) -> String{
            return """
                {"duration":{"value":\(v),"viewId":\(id)}}
            """;
        }
        self.playerStateEventSink?(data(v: duration.seconds, id: viewId))
    }
}


extension FlutterIvsPlayerView {
    func player(_ player: IVSPlayer, didFailWithError error:AmazonIVSPlayer.NSError) {
        func data (v:NSError,id:Int32) -> String{
            return """
                {"error":{"value":\(v),"viewId":\(id)}}
            """;
        }
        self.playerStateEventSink?(data(v: error, id: viewId))
    }
}

extension FlutterIvsPlayerView {
    func player(_ player: IVSPlayer, didChangeQuality quality:IVSQuality?) {
        func data (w:Int,h:Int,name:String,id:Int32) -> String{
            self.view()
            return """
                {"quality":{"width":\(w),"height":\(h),"name":"\(name)","viewId":\(id)}}
            """;
        }
        self.playerStateEventSink?(data(w: (quality?.width ?? 0), h: (quality?.height ?? 0), name: (quality?.name ?? ""), id: viewId))
    }
}

//extension FlutterIvsPlayerView {
//    func player(_ player: IVSPlayer, didFailWithError error:AmazonIVSPlayer.NSError) {
//        self.playerStateEventSink?("ER#\(error)@\(viewId)")
//    }
//}
