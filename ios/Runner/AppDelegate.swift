import UIKit
import Flutter
import FirebaseCore
import FirebaseAnalytics

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
     GMSServices.provideAPIKey("AIzaSyD3RM-zLd6AhNzcBSFthoNHKcI6Ht5R49s")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
