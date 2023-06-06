import Flutter
import UIKit
import AVKit
import AmazonIVSPlayer

public class IvsPlayerPlugin: NSObject, FlutterPlugin,IvsPlayerApi {
    private static var flutterState:FlutterState!
    
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        flutterState = FlutterState(binaryMessenger: registrar.messenger(), textureRegistry: registrar.textures())
    }
    
    func autoQualityMode(mode: AutoQualityModeMessage) throws -> Bool {
            <#code#>
    }
    
    func looping(loopingMessage: LoopingMessage) throws -> Bool {
        <#code#>
    }
    
    func mute(mutedMessage: MutedMessage) throws -> Bool {
        <#code#>
    }
    
    func playbackRate(playbackRateMessage: PlaybackRateMessage) throws -> Double {
        <#code#>
    }
    
    func volume(volumeMessage: VolumeMessage) throws -> Double {
        <#code#>
    }
    
    func videoDuration(viewMessage: ViewMessage) throws -> Double {
        <#code#>
    }
    
    func playbackPosition(viewMessage: ViewMessage) throws -> Double {
        <#code#>
    }
    
    func qualities(viewMessage: ViewMessage) throws -> [FQuality] {
        <#code#>
    }
    
    func quality(qualityMessage: FQualityMessage) throws -> FQuality {
        <#code#>
    }
    
    func create() throws -> Int64? {
        <#code#>
    }
    
    func pause(viewMessage: ViewMessage) throws {
        <#code#>
    }
    
    func load(loadMessage: LoadMessage) throws {
        <#code#>
    }
    
    func play(viewMessage: ViewMessage) throws {
        <#code#>
    }
    
    func seekTo(seekMessage: SeekMessage) throws {
        <#code#>
    }
    
    func dispose(viewMessage: ViewMessage) throws {
        <#code#>
    }
    
    
    
    private var flutterState:FlutterState!
    

  
    
    
    
//    public static func register(with registrar: FlutterPluginRegistrar) {
//
//        self.flutterState = FlutterState(binaryMessenger: <#T##FlutterBinaryMessenger#>, textureRegistry: <#T##FlutterTextureRegistry#>)
//
//        registrar.textures();
//        let factory = FLNativeViewFactory(messenger: registrar.messenger())
//        registrar.register(factory, withId: IVSConstants.viewTypeIvsPlayer)
//    }
}


//class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
//    private var messenger: FlutterBinaryMessenger
//
//    init(messenger: FlutterBinaryMessenger) {
//        self.messenger = messenger
//        super.init()
//    }
//
//    func create(
//        withFrame frame: CGRect,
//        viewIdentifier viewId: Int64,
//        arguments args: Any?
//    ) -> FlutterPlatformView {
//        return FlutterIvsPlayerView(
//            frame: frame,
//            viewIdentifier: viewId,
//            arguments: args,
//            binaryMessenger: messenger)
//    }
//}
//

class FlutterState{
    let binaryMessenger:FlutterBinaryMessenger
    let textureRegistry:FlutterTextureRegistry
    
    init(binaryMessenger: FlutterBinaryMessenger, textureRegistry: FlutterTextureRegistry) {
        self.binaryMessenger = binaryMessenger
        self.textureRegistry = textureRegistry
    }
    
    func startListening(ivsPlayerPlugin:IvsPlayerPlugin,binaryMessenger:FlutterBinaryMessenger){
        IvsPlayerApiSetup.setUp(binaryMessenger: binaryMessenger, api: ivsPlayerPlugin)
    }
    
    func stopListening( binaryMessenger: FlutterBinaryMessenger) {
        IvsPlayerApiSetup.setUp(binaryMessenger: binaryMessenger,api: nil)
    }
}

