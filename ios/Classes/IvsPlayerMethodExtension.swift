//
//  IvsPlayerMethodExtension.swift
//  ivs_player
//
//  Created by Utkarsh Sharma on 25/03/23.
//

import Foundation
import AmazonIVSPlayer
import AmazonIVSPlayer.IVSQuality



extension IvsPlayer {
    
    func quality(qualityMessage: FQualityMessage) throws -> FQuality {
        let p = ivsPlayerView.player
        if(qualityMessage.quality != nil){
            for qual in p?.qualities ?? []{
                if(qual.name == qualityMessage.quality?.name){
                    p?.quality = qual
                    break
                }
            }
        }
        let q = p?.quality
        return   FQuality(name: q?.name ?? "", height:Int64(Int32( q?.height ?? 0)), width:Int64(Int32( q?.width ?? 0)))

    }
    
    
    func qualities(viewMessage: ViewMessage) throws -> [FQuality] {
        let q = ivsPlayerView.player?.qualities ?? []
        var qualities: [FQuality] = []
        
        for qual in q{
            qualities.append(FQuality(name: qual.name, height: Int64(Int32( qual.height)) , width: Int64(Int32( qual.width))))
        }
        return qualities
    }
    
    

    

    
    func playbackPosition(viewMessage: ViewMessage) throws -> Double {
        return ivsPlayerView.player?.position.seconds ?? 0.0
    }
    
    
    func autoQualityMode(mode: AutoQualityModeMessage) throws -> Bool {
        let p = ivsPlayerView.player
        if(mode.autoQualityMode != nil){
            p?.autoQualityMode = mode.autoQualityMode!
            return mode.autoQualityMode!
        }else{
            return p?.autoQualityMode ?? true
        }
    }
    
    func looping(loopingMessage: LoopingMessage) throws -> Bool {
        let p = ivsPlayerView.player
        if(loopingMessage.looping != nil){
            p?.looping = loopingMessage.looping!
            return loopingMessage.looping!
        }else{
            return p?.looping ?? true
        }
    }
    
    func mute(mutedMessage: MutedMessage) throws -> Bool {
        let p = ivsPlayerView.player
        if(mutedMessage.muted != nil){
            p?.muted = mutedMessage.muted!
            return mutedMessage.muted!
        }else{
            return p?.muted ?? true
        }
    }
    
    func playbackRate(playbackRateMessage: PlaybackRateMessage) throws -> Double {
        let p = ivsPlayerView.player
        if(playbackRateMessage.playbackRate != nil){
            p?.playbackRate = Float(playbackRateMessage.playbackRate ?? 0.0)
            return playbackRateMessage.playbackRate!
        }else{
            return Double(p?.playbackRate ?? 0.0)
        }
    }
    
    func volume(volumeMessage: VolumeMessage) throws -> Double {
        let p = ivsPlayerView.player
        if(volumeMessage.volume != nil){
            p?.volume = Float(volumeMessage.volume ?? 0.0)
            return volumeMessage.volume!
        }else{
            return Double(p?.volume ?? 0.0)
        }
    }
    
    func videoDuration(viewMessage: ViewMessage) throws -> Double {
        let p = ivsPlayerView.player
        return p?.duration.seconds ?? 0.0
    }
    
    
    func seekTo(seekMessage: SeekMessage) throws {
        ivsPlayerView.player?.seek(to: CMTime(seconds: seekMessage.seconds, preferredTimescale: 1000))
    }

    func pause(viewMessage: ViewMessage) throws {
        ivsPlayerView.player?.pause()
    }
    
    func load(loadMessage: LoadMessage) throws {
        ivsPlayerView.player?.load(URL(string: loadMessage.url))
    }
    
    func play(viewMessage: ViewMessage) throws {
        ivsPlayerView.player?.play()
    }
    
    func dispose(viewMessage: ViewMessage) throws {
//        ivsPlayerView.player?.removeTimeObserver(self)
//        ivsPlayerView.player?.removeTimeObserver(self)
        // ivsPlayerView.player?.pause()
        CacheUtil.i.removePlayer(key: Int32(viewId))
        // ivsPlayerView.player?.play()
    }
}

