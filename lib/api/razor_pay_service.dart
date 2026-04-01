import 'dart:html' as html;
import 'dart:js_util' as js_util;
import 'package:js/js_util.dart' show allowInterop;

typedef PaymentSuccess = void Function(
    String paymentId,
    String orderId,
    String signature,
    );

typedef PaymentFailure = void Function(String message);

class RazorpayWebService {
  void openCheckout({
    required String key,
    required int amount,
    required String orderId,
    required PaymentSuccess onSuccess,
    required PaymentFailure onFailure,
  }) {
    final options = js_util.jsify({
      "key": key,
      "amount": amount * 100,
      "currency": "INR",
      "name": "Adynee",
      "description": "Payment",
      "order_id": orderId,
      "image": "https://dummyimage.com/100x100/000/fff.png&text=Adynee",

      /// ✅ SUCCESS
      "handler": allowInterop((response) {
        html.window.console.log("✅ SUCCESS RAW: $response");

        final data = js_util.dartify(response);

        if (data is Map) {
          final res = Map<String, dynamic>.from(data);

          final paymentId = res['razorpay_payment_id']?.toString();
          final orderId = res['razorpay_order_id']?.toString();
          final signature = res['razorpay_signature']?.toString();

          if (paymentId != null &&
              orderId != null &&
              signature != null) {
            onSuccess(paymentId, orderId, signature);
          } else {
            onFailure("Missing payment data");
          }
        } else {
          onFailure("Invalid response format");
        }
      }),

      /// ❌ MODAL CLOSE
      "modal": {
        "ondismiss": allowInterop(() {
          html.window.console.log("❌ Payment Cancelled");
          onFailure("Payment cancelled by user");
        })
      },

      "theme": {"color": "#3399cc"},
    });

    final razorpay = js_util.callConstructor(
      js_util.getProperty(html.window, 'Razorpay'),
      [options],
    );

    /// ❌ PAYMENT FAILED EVENT
    js_util.callMethod(razorpay, 'on', [
      'payment.failed',
      allowInterop((response) {
        html.window.console.log("❌ FAILED RAW: $response");

        final data = js_util.dartify(response);
        if (data is Map) {
          final res = Map<String, dynamic>.from(data);
          final error = res['error']?['description'] ?? "Payment failed";
          onFailure(error.toString());
        } else {
          onFailure("Payment failed");
        }
      })
    ]);

    html.window.console.log("🚀 Opening Razorpay...");
    js_util.callMethod(razorpay, 'open', []);
  }
}