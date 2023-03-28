//
//  IvsPlayerMethodExtension.swift
//  ivs_player
//
//  Created by Utkarsh Sharma on 25/03/23.
//

import Foundation
import AmazonIVSPlayer



extension FlutterIvsPlayerView: IvsPlayerApi {
    func playbackPosition(viewMessage: ViewMessage) throws -> Double {
        return CacheUtil.i.getPlayerView(key: viewMessage.viewId)?.player?.position.seconds ?? 0.0
    }
    
    
    func autoQualityMode(mode: AutoQualityModeMessage) throws -> Bool {
        let p = CacheUtil.i.getPlayerView(key: mode.viewId)?.player
        if(mode.autoQualityMode != nil){
            p?.autoQualityMode = mode.autoQualityMode!
            return mode.autoQualityMode!
        }else{
            return p?.autoQualityMode ?? true
        }
    }
    
    func looping(loopingMessage: LoopingMessage) throws -> Bool {
        let p = CacheUtil.i.getPlayerView(key: loopingMessage.viewId)?.player
        if(loopingMessage.looping != nil){
            p?.looping = loopingMessage.looping!
            return loopingMessage.looping!
        }else{
            return p?.looping ?? true
        }
    }
    
    func mute(mutedMessage: MutedMessage) throws -> Bool {
        let p = CacheUtil.i.getPlayerView(key: mutedMessage.viewId)?.player
        if(mutedMessage.muted != nil){
            p?.muted = mutedMessage.muted!
            return mutedMessage.muted!
        }else{
            return p?.muted ?? true
        }
    }
    
    func playbackRate(playbackRateMessage: PlaybackRateMessage) throws -> Double {
        let p = CacheUtil.i.getPlayerView(key: playbackRateMessage.viewId)?.player
        if(playbackRateMessage.playbackRate != nil){
            p?.playbackRate = Float(playbackRateMessage.playbackRate ?? 0.0)
            return playbackRateMessage.playbackRate!
        }else{
            return Double(p?.playbackRate ?? 0.0)
        }
    }
    
    func volume(volumeMessage: VolumeMessage) throws -> Double {
        let p = CacheUtil.i.getPlayerView(key: volumeMessage.viewId)?.player
        if(volumeMessage.volume != nil){
            p?.volume = Float(volumeMessage.volume ?? 0.0)
            return volumeMessage.volume!
        }else{
            return Double(p?.volume ?? 0.0)
        }
    }
    
    func videoDuration(viewMessage: ViewMessage) throws -> Double {
        let p = CacheUtil.i.getPlayerView(key: viewMessage.viewId)?.player
        return p?.duration.seconds ?? 0.0
    }
    
    
    func seekTo(seekMessage: SeekMessage) throws {
        CacheUtil.i.getPlayerView(key: seekMessage.viewId)?.player?.seek(to: CMTime(seconds: seekMessage.seconds, preferredTimescale: 1))
    }

    func pause(viewMessage: ViewMessage) throws {
        CacheUtil.i.getPlayerView(key: viewMessage.viewId)?.player?.pause()
    }
    
    func load(loadMessage: LoadMessage) throws {
        CacheUtil.i.getPlayerView(key: loadMessage.viewId)?.player?.load(URL(string: loadMessage.url))
    }
    
    func play(viewMessage: ViewMessage) throws {
        CacheUtil.i.getPlayerView(key: viewMessage.viewId)?.player?.play()
    }
    
    func dispose(viewMessage: ViewMessage) throws {
        CacheUtil.i.removePlayer(key: viewMessage.viewId)
    }
}
