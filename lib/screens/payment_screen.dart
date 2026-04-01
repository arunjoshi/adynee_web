import 'dart:convert';

import 'package:adynee_web/widgets/ad_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'dart:html';
import 'dart:js_util' as js_util;
import 'dart:html' as html;

import '../api/api_service.dart';
import '../model/order_response.dart';
import '../utils/DialogHelper.dart';
import '../utils/prefrence_service.dart';

class PaymentScreen extends StatefulWidget {
  final String date;
  final String time;

  const PaymentScreen({super.key,  required this.date,
    required this.time,});

  @override
  State<PaymentScreen> createState() => _paymentScreenState();
}

class _paymentScreenState extends State<PaymentScreen>  {


  @override
  Widget build(BuildContext context) {
    //print("aaDadADadsADSA  ${widget.date}");

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: Center(
        child: Container(
          width: 900,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// Title
              const Text(
                "Voilla, slot is available !!!\nOur Trainer is waiting for you !!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff5bb3b0),
                ),
              ),

              const SizedBox(height: 60),

              /// Content Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  /// Left Side (Inputs + Button)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// Payment Details Field
                      Container(
                        width: 280,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xff5bb3b0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text(
                          "Payment Details ",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Placeholder Field
                      Container(
                        width: 280,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xff5bb3b0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "for Slot at ${widget.date} , ${widget.time}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),

                      const SizedBox(height: 40),

                      /// Button
                      CustomButton(text: "Let’s make payment", isLoading: false, onTap: () async{
                        String? userId = await PreferencesService.getUserId();

                        await createOrder(context, "1999", "assessment", "0", userId!);


                        //openRazorpayCheckout(orderId, amount, context);

                      }),
/*                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                        ),
                        child: const Text("Let’s Go"),
                      ),*/
                    ],
                  ),

                  /// Right Side (Price)
                  const Text(
                    "Rs. 1,999/-",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createOrder(BuildContext buildContext, String price, String courseTye,
      String courseId, String userId) async {

    try{
      DialogHelper.showLoader(buildContext);
      final ApiService _apiService = ApiService();

      int amount = int.parse(price);

      var sds = {
        "user_id": userId,
        "course_id": courseId,
        "course_type":courseTye,
        "amount": amount.toString(),
        "status": "pending",
        "order_id": "",
        "payment_id": "",
        "signature": "",
        "created_at": DateTime.now().toString()
      };

      print("sds ${json.encode(sds)}");

      final apiResponse = await _apiService.createOrder(sds);

      //var data = apiResponse.data;
      OrderResponse order = OrderResponse.fromJson(apiResponse.data);

      if(apiResponse.status == "success"){
        print("order.id :- ${order.id}");
        openRazorpayCheckout(order.id, 1, buildContext);

      }else{
        DialogHelper.hideLoader(buildContext);
        DialogHelper.showAppDialog(context: buildContext, title: "Error", message: "Issue while creating the order for enrollment", isSuccess: false);

      }


      DialogHelper.hideLoader(buildContext);

    }catch(ex, stack){
      DialogHelper.hideLoader(buildContext);

      print("Exception :- ${ex} --  ${stack}");
      DialogHelper.showAppDialog(context: buildContext, title: "Error", message: "${ex.toString()}", isSuccess: false);
    }
  }

  void openRazorpayCheckout(String? orderId, int amount, BuildContext context) {
    final options = js_util.jsify({
      "key": "rzp_test_SVowINPm3oamjp",
      "amount": amount * 100,
      "currency": "INR",
      "name": "Adynee",
      "description": "Test Payment",
      "order_id": orderId,

      // ✅ SUCCESS CALLBACK
      "handler": (response) async {
        print("SUCCESS: $response");
        final raw = js_util.dartify(response) ;


        if (raw is Map) {
          final res = Map<String, dynamic>.from(raw);

          final paymentId = res['razorpay_payment_id']?.toString();
          final orderId = res['razorpay_order_id']?.toString();
          final signature = res['razorpay_signature']?.toString();

          if (paymentId == null || orderId == null || signature == null) {
            print("❌ Missing data");
            return;
          }
          verifyPayment(paymentId, orderId, signature, context);
        }
      },
      // ❌ FAILURE CALLBACK
      "modal": {
        "ondismiss": () {
          DialogHelper.showAppDialog(context: context, title: "Payment", message: "You had cancelled the payment");
          print("Payment Cancelled ❌");
        }
      }
    });
    js_util.callMethod(html.window, 'openRazorpayCheckout', [options]);
  }

  // 🔐 Verify Payment with Backend
  Future<void> verifyPayment( String paymentId, String orderId, String sign, BuildContext buildContext) async {

    final ApiService _apiService = ApiService();

    Map<String, dynamic> data = {"razorpay_order_id": orderId,
      "razorpay_payment_id": paymentId,
      "razorpay_signature": sign ,};
    final apiResponse = await _apiService.verifyPayment(data);

    if(apiResponse.status == "success"){
      DialogHelper.showAppDialog(context: buildContext, title: "Success", message: "Payment is successfull,"
          " please use this transction id ${paymentId} for future reference", isSuccess: true,
      onOk: (){
        GoRouter.of(context).go('/confirmation', extra: {"assessment_date":"${widget.date.toString()}",
          "assessment_time":"${widget.time.toString()}", "isAssessment" : true});
      });
    }else{
      DialogHelper.hideLoader(buildContext);
      DialogHelper.showAppDialog(context: buildContext, title: "Error", message: "Issue while creating the order for enrollment", isSuccess: false);
    }
  }

}