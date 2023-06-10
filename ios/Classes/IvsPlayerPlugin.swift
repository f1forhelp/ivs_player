import Flutter
import UIKit
import AVKit
import AmazonIVSPlayer

public class IvsPlayerPlugin: NSObject, FlutterPlugin {
//    private static var flutterState:FlutterState!
    
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
//        flutterState = FlutterState(binaryMessenger: registrar.messenger(), textureRegistry: registrar.textures(),flutterPluginRegistrar: registrar)
        
      
                let factory = FLNativeViewFactory(messenger: registrar.messenger())
                registrar.register(factory, withId: IVSConstants.viewTypeIvsPlayer)
    }
    
    
//
//    func autoQualityMode(mode: AutoQualityModeMessage) throws -> Bool {
//        var v:Bool = true
//        do{
//            v = try (CacheUtil.i.getPlayer(key: Int32(mode.viewId))?.autoQualityMode(mode: mode) ?? false)
//        }catch let error{
//            throw error
//        }
//        return   v
//    }
//
//    func looping(loopingMessage: LoopingMessage) throws -> Bool {
//        var v:Bool = false
//        do{
//            v = try (CacheUtil.i.getPlayer(key: Int32(loopingMessage.viewId))?.looping(loopingMessage: loopingMessage) ?? false)
//        }catch let error{
//            throw error
//        }
//        return   v
//    }
//
//    func mute(mutedMessage: MutedMessage) throws -> Bool {
//        var v:Bool = false
//        do{
//            v = try (CacheUtil.i.getPlayer(key: Int32(mutedMessage.viewId))?.mute(mutedMessage: mutedMessage) ?? false)
//        }catch let error{
//            throw error
//        }
//        return   v
//
//    }
//
//    func playbackRate(playbackRateMessage: PlaybackRateMessage) throws -> Double {
//        var v:Double = 1
//        do{
//            v = try (CacheUtil.i.getPlayer(key: Int32(playbackRateMessage.viewId))?.playbackRate(playbackRateMessage:playbackRateMessage) ?? 1)
//        }catch let error{
//            throw error
//        }
//        return   v
//    }
//
//    func volume(volumeMessage: VolumeMessage) throws -> Double {
//        var v:Double = 1
//        do{
//            v = try (CacheUtil.i.getPlayer(key: Int32(volumeMessage.viewId))?.volume(volumeMessage: volumeMessage) ?? 1)
//        }catch let error{
//            throw error
//        }
//        return   v
//    }
//
//    func videoDuration(viewMessage: ViewMessage) throws -> Double {
//        var v:Double = 1
//        do{
//            v = try (CacheUtil.i.getPlayer(key: Int32(viewMessage.viewId))?.videoDuration(viewMessage:viewMessage) ?? 0)
//        }catch let error{
//            throw error
//        }
//        return   v
//    }
//
//    func playbackPosition(viewMessage: ViewMessage) throws -> Double {
//        var v:Double = 1
//        do{
//            v = try (CacheUtil.i.getPlayer(key: Int32(viewMessage.viewId))?.playbackPosition(viewMessage:viewMessage) ?? 0)
//        }catch let error{
//            throw error
//        }
//        return   v
//    }
//
//    func qualities(viewMessage: ViewMessage) throws -> [FQuality] {
//        var v:[FQuality] = []
//        do{
//            v = try (CacheUtil.i.getPlayer(key: Int32(viewMessage.viewId))?.qualities(viewMessage:viewMessage) ?? [])
//        }catch let error{
//            throw error
//        }
//        return   v
//    }
//
//    func quality(qualityMessage: FQualityMessage) throws -> FQuality {
//        var v:FQuality = FQuality(name: "", height: 0, width: 0)
//        do{
//            v = try (CacheUtil.i.getPlayer(key: Int32(qualityMessage.viewId))?.quality(qualityMessage: qualityMessage) ?? v)
//        }catch let error{
//            throw error
//        }
//        return   v
//    }
//
//    func create() throws -> Int64? {
//
//        return nil
//
//        //    let playerInstance = IvsPlayer( binaryMessenger: flutterState.binaryMessenger)
////      let textureId = flutterState.textureRegistry.register(playerInstance)
////        CacheUtil.i.setPlayer(key: textureId, playerInstance: playerInstance)
//    }
//
//    func pause(viewMessage: ViewMessage) throws {
//        try CacheUtil.i.getPlayer(key: Int32(viewMessage.viewId))?.pause(viewMessage: viewMessage)
//    }
//
//    func load(loadMessage: LoadMessage) throws {
//        try CacheUtil.i.getPlayer(key: Int32(loadMessage.viewId))?.load(loadMessage: loadMessage)
//
//    }
//
//    func play(viewMessage: ViewMessage) throws {
//        try CacheUtil.i.getPlayer(key: Int32(viewMessage.viewId))?.play(viewMessage: viewMessage)
//
//    }
//
//    func seekTo(seekMessage: SeekMessage) throws {
//        try CacheUtil.i.getPlayer(key: Int32(seekMessage.viewId))?.seekTo(seekMessage: seekMessage)
//
//    }
//
//    func dispose(viewMessage: ViewMessage) throws {
//        try CacheUtil.i.getPlayer(key: Int32(viewMessage.viewId))?.dispose(viewMessage: viewMessage)
//        CacheUtil.i.removePlayer(key: Int32(viewMessage.viewId))
//    }
//
//
    
//    private var flutterState:FlutterState!
    
//    public static func register(with registrar: FlutterPluginRegistrar) {
//
//        self.flutterState = FlutterState(binaryMessenger: <#T##FlutterBinaryMessenger#>, textureRegistry: <#T##FlutterTextureRegistry#>)
//
//        registrar.textures();
//        let factory = FLNativeViewFactory(messenger: registrar.messenger())
//        registrar.register(factory, withId: IVSConstants.viewTypeIvsPlayer)
//    }
}


class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
//        return IvsPlayer(
//            frame: frame,
//            viewIdentifier: viewId,
//            arguments: args,
//            binaryMessenger: messenger)
        
//        if(args != nil){
//           return CacheUtil.i.getPlayer(key: (args as? Int64))
//        }
        
        let argu : Dictionary<String, Any>? = args as? Dictionary<String, Any>
        var ivsP:IvsPlayer
        if(argu != nil){
           var viewId = argu!["viewId"] as? Int64
            ivsP =  CacheUtil.i.getPlayer(key:Int32(viewId ?? 0))!
        }else{
            ivsP = IvsPlayer(binaryMessenger: messenger, withFrame: frame, viewIdentifier: viewId, arguments: args)
        }
        
        return ivsP
    }
    
    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}
//

//class FlutterState{
//    let binaryMessenger:FlutterBinaryMessenger
//    let textureRegistry:FlutterTextureRegistry
//    let flutterPluginRegistrar:FlutterPluginRegistrar
//
//    init(binaryMessenger: FlutterBinaryMessenger, textureRegistry: FlutterTextureRegistry, flutterPluginRegistrar:FlutterPluginRegistrar) {
//        self.binaryMessenger = binaryMessenger
//        self.textureRegistry = textureRegistry
//        self.flutterPluginRegistrar = flutterPluginRegistrar
//    }
//
//    func startListening(ivsPlayerPlugin:IvsPlayerPlugin,binaryMessenger:FlutterBinaryMessenger){
//        IvsPlayerApiSetup.setUp(binaryMessenger: binaryMessenger, api: ivsPlayerPlugin)
//    }
//
//    func stopListening( binaryMessenger: FlutterBinaryMessenger) {
//        IvsPlayerApiSetup.setUp(binaryMessenger: binaryMessenger,api: nil)
//    }
//}

