import 'dart:convert';

import 'package:adynee_web/model/course_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../api/api_service.dart';
import '../model/APIResponse.dart';
import '../model/order_response.dart';
import '../utils/DialogHelper.dart';
import '../utils/prefrence_service.dart';

import 'dart:html';
import 'dart:js_util' as js_util;
import 'dart:html' as html;

class TrainingFormViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool isLoading = false;




  Future<ApiResponse> submitForm({
    required String name,
    required String mobile,
    required String email,
    required String animal,
    required String age,
  }) async {

    isLoading = true;
    notifyListeners();

    try {

      var sdfs = {
        "name": name,
        "mobile": mobile,
        "email": email,
        "animal": animal,
        "createdOn": DateTime.now().toString(),
        "courseEnrolled": "",
        "isEnrolled": false,
        "occupation": ""
      };
      print("sakmakldmalkdm - $sdfs");


      final apiResponse = await _apiService.submitUser(sdfs);


      isLoading = false;
      notifyListeners();

      return apiResponse;
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
      return ApiResponse(status: "failure", message: "Exception :- ${e.toString()}", data: {});

    }
  }

  Future<ApiResponse> submitEnrollmentUserForm({
    required String name,
    required String mobile,
    required String email,
    required String animal,
    required String age,
    required BuildContext context, required CourseModel course,
  }) async {

    isLoading = true;
    notifyListeners();

    try {

      var sdfs = {
        "name": name,
        "mobile": mobile,
        "email": email,
        "animal": animal,
        "createdOn": DateTime.now().toString(),
        "courseEnrolled": "",
        "isEnrolled": false,
        "occupation": ""
      };
      print("sakmakldmalkdm - $sdfs");


      final apiResponse = await _apiService.submitUser(sdfs);
      if (apiResponse.status == "success") {
        if (apiResponse.data is Map<String, dynamic>) {

          String userId = apiResponse.data['user_id'];
          await PreferencesService.setUserId("${userId}");
          createOrder(context, course.price , "course", course.id, userId);

        }else{

          DialogHelper.showAppDialog(context: context, isSuccess: false, title: "error", message: "Invalid Key Value Pair");

        }
      }else{
        DialogHelper.showAppDialog(context: context, isSuccess: false, title: "error", message: apiResponse.message,);
      }
      isLoading = false;
      notifyListeners();

      return apiResponse;
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
      return ApiResponse(status: "failure", message: "Exception :- ${e.toString()}", data: {});

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
      print("ORDER RESPONSE: ${apiResponse.data}");
      //var data = apiResponse.data;
      OrderResponse order = OrderResponse.fromJson(apiResponse.data);

      if(apiResponse.status == "success"){
        print("order.id :- ${order.id}");
        openRazorpayCheckout(order.id, amount, buildContext);

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
      "image": "https://dummyimage.com/100x100/000/fff.png&text=Adynee",

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
            GoRouter.of(buildContext).go('/confirmation', extra: {"assessment_date":"",
              "assessment_time":"", "isAssessment" : false});
          });
    }else{
      DialogHelper.hideLoader(buildContext);
      DialogHelper.showAppDialog(context: buildContext, title: "Error", message: "Issue while creating the order for enrollment", isSuccess: false);
    }
  }

  Future<bool> getUsers({
    required String name,
    required String mobile,
    required String email,
    required String animal,
  }) async {
   // if (!_validate(name, mobile, email, animal)) return false;

    isLoading = true;
    notifyListeners();

    try {
      await _apiService.getUsers();

      return true;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool _validate(String name, String mobile, String email, String animal) {
    if (name.isEmpty || mobile.isEmpty || email.isEmpty || animal.isEmpty) {
      return false;
    }

    if (mobile.length != 10) return false;

    if (!email.contains("@")) return false;

    return true;
  }
}