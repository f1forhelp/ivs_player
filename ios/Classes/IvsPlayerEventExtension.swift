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
        switch (state){
        case .ready:
                self.playerStateEventSink?("ST#1@\(viewId)")
        case .idle:
                self.playerStateEventSink?("ST#2@\(viewId)")
        case .playing:
                self.playerStateEventSink?("ST#3@\(viewId)")
        case .buffering:
                self.playerStateEventSink?("ST#4@\(viewId)")
        case .ended:
                self.playerStateEventSink?("ST#5@\(viewId)")
        default:
            self.playerStateEventSink?("ST#-1@\(viewId)")
        }
    }
}

extension FlutterIvsPlayerView:IVSPlayer.Delegate {
    func player(_ player: IVSPlayer, didChangeDuration duration:AmazonIVSPlayer.CMTime) {
        
        self.playerStateEventSink?("DU#\(duration.seconds)@\(viewId)")
    }
}


extension FlutterIvsPlayerView {
    func player(_ player: IVSPlayer, didFailWithError error:AmazonIVSPlayer.NSError) {
        self.playerStateEventSink?("ER#\(error)@\(viewId)")
    }
}
