import 'package:flutter/cupertino.dart';

import '../api/api_service.dart';
import '../model/APIResponse.dart';

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


      final apiResponse = await _apiService.submitUser({
        "name": name,
        "mobile": mobile,
        "email": email,
        "animal": animal,
        "createdOn": DateTime.now().toString(),
        "courseEnrolled": "",
        "isEnrolled": false,
        "occupation": ""
      });
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