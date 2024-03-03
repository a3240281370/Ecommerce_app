import 'package:flutter/services.dart';

class PaymentService {
  static const MethodChannel _channel = MethodChannel('sellingtest');
  
  static Future<void> startPayment() async {
    try {
      final result = await _channel.invokeMethod('startPayment');
      print("Payment result: $result");
    } on PlatformException catch (e) {
      print("Failed to start payment: '${e.message}'.");
    }
  }
}
