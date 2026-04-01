import 'dart:convert';

import 'package:adynee_web/model/course_model.dart';
import 'package:adynee_web/model/order_response.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:html';
import 'dart:js_util' as js_util;
import 'dart:html' as html;

import '../../api/api_service.dart';
import '../../utils/DialogHelper.dart';
import '../../utils/prefrence_service.dart';

class CourseDetailPage extends StatelessWidget {
  final CourseModel course;
  const CourseDetailPage({required this.course, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: Center(
        child: Container(
          width: 900,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// HEADER
              Row(
                children: [
                  InkWell(child: Icon(Icons.arrow_back), onTap: (){
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/'); // fallback
                    }
                  },),

                ],
              ),

              const SizedBox(height: 40),

              /// TITLE ROW
              Row(
                children: [
                  Text(
                    "${getCategory(course.sp_id)}",
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff59b6b2),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black26),
                    ),
                    child: Text(course.name,  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color:  Colors.black,
                    ),),
                  )
                ],
              ),

              const SizedBox(height: 20),

              /// INNER CARD
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black26),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// DESCRIPTION
                     Text(course.desc,
                       style: GoogleFonts.poppins(
                         fontSize: 17,
                         fontWeight: FontWeight.w300,
                         color:  Colors.black,
                       ),
                    ),

                    const SizedBox(height: 20),

                    /// PRICE + BUTTON
                    Row(
                      children: [
                        Text(
                          "Rs. ${course.price}/-",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                        Text("Duration - ${course.duration} Weeks",  style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),),

                        const Spacer(),

                        InkWell(
                          onTap:  () async {
                            GoRouter.of(context).go('/enrolle_user_detail', extra: course);
                           /* String? userid = "6e23e769-ce62-49e2-8dcd-9a28e1fe341d";//await PreferencesService.getUserId();

                            await createOrder(context, course.price, "course", course.id, userid!);*/
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black45),
                            ),
                            child: const Text("Enroll",  style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// BOTTOM INDICATOR
              Container(
                height: 8,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getCategory(String spId) {
    if (spId == "71b2e066-86e6-40bb-8b61-702401fc314c" ||
        spId == "39ae0631-b362-4674-bb4d-86922be6a959") {
      return "MICRO COURSES";
    } else if (spId == "6bfecfd4-b95d-4a28-9a4a-cc536dad09c8") {
      return "MEGA BATCHES";
    } else if (spId == "5ee1aaf9-8822-46b8-a562-3ed55fe2f87e") {
      return "STANDARD COURSES";
    } else {
      return "BATCHES";
    }
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
    print("paymentId: ${paymentId}");
    print("orderId: ${orderId}");
    print("sign: ${sign}");
    final ApiService _apiService = ApiService();

    Map<String, dynamic> data = {"razorpay_order_id": orderId,
      "razorpay_payment_id": paymentId,
      "razorpay_signature": sign ,};
    final apiResponse = await _apiService.verifyPayment(data);

    if(apiResponse.status == "success"){
      DialogHelper.showAppDialog(context: buildContext, title: "Success", message: "Payment is suucessfull", isSuccess: true);

    }else{
      DialogHelper.hideLoader(buildContext);
      DialogHelper.showAppDialog(context: buildContext, title: "Error", message: "Issue while creating the order for enrollment", isSuccess: false);

    }


  }
}