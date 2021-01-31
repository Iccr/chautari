import UIKit
import Flutter
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // AIzaSyApsLuDZQSpvfAfZOGVHa4nIDROtTJnTgI
     GMSServices.provideAPIKey("AIzaSyApsLuDZQSpvfAfZOGVHa4nIDROtTJnTgI")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
