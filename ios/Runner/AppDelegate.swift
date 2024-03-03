import UIKit
import ECPayPaymentGatewayKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // ECPay SDK 初始化代码
    var envStr:String = "prod"
    if let env = Bundle.main.object(forInfoDictionaryKey: "ENV") as? String {
        envStr = env.lowercased()
    }
    switch envStr {
    case "stage":
        ECPayPaymentGatewayManager.sharedInstance().initialize(env: .Stage)
    default:
        ECPayPaymentGatewayManager.sharedInstance().initialize(env: .Prod)
    }

    // 设置 Flutter 方法通道
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let paymentChannel = FlutterMethodChannel(name: "sellingtest", binaryMessenger: controller.binaryMessenger)
    
    paymentChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // 检测从 Flutter 端接收到的方法调用
      if call.method == "startPayment" {
        // 正确调用 PaymentManager 的 startPayment 方法
        PaymentManager.shared.startPayment { (success, message) in
            if success {
                result("支付成功: \(message)")
            } else {
                result(FlutterError(code: "PAYMENT_FAILED", message: "支付失败: \(message)", details: nil))
            }
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
