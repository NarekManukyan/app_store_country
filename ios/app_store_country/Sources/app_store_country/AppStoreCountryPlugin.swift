import Flutter
import StoreKit
import UIKit

public class AppStoreCountryPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "app_store_country", binaryMessenger: registrar.messenger())
    let instance = AppStoreCountryPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getCountryCode":
      Task {
        let countryCode = await getCountryCode()
        result(countryCode)
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func getCountryCode() async -> String? {
    if #available(iOS 15.0, *) {
      let storefront = await Storefront.current
      return storefront?.countryCode
    }

    return SKPaymentQueue.default().storefront?.countryCode
  }
}
