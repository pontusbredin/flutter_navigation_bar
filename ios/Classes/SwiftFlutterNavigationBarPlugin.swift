import Flutter
import UIKit

public class SwiftFlutterNavigationBarPlugin: NSObject, FlutterPlugin {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_navigation_bar", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterNavigationBarPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            case "equalSides":
                result(true)
            default:
                result(FlutterMethodNotImplemented)
        }
    }


}
