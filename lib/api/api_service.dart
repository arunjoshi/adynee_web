import 'package:dio/dio.dart';

import '../model/APIResponse.dart';

class ApiService {

  //String BASE_URL = "https://x2myho62dsehwb6uzohajvm3ai0txqmf.lambda-url.eu-north-1.on.aws/";

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://x2myho62dsehwb6uzohajvm3ai0txqmf.lambda-url.eu-north-1.on.aws",
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  Future<void> getUsers() async {
    try {
      final response = await _dio.get("/users");
      print(response.data);
    } catch (e) {
      print("ERROR: $e");
    }

  }


  Future<ApiResponse> submitUser(Map<String, dynamic> data) async {
    final response = await _dio.post("/users", data: data);

    final apiResponse = ApiResponse.fromJson(
      response.data,
          (data) => data, // simple map
    );

    return apiResponse;
  }

  Future<ApiResponse> getCourses() async {
    final response = await _dio.get("/course");

    final apiResponse = ApiResponse.fromJson(
      response.data,
          (data) => data, // simple map
    );

    return apiResponse;
  }
  Future<ApiResponse> createOrder( Map<String, dynamic> data) async {
    final response = await _dio.post("/create-order", data: data);

    final apiResponse = ApiResponse.fromJson(
      response.data,
          (data) => data, // simple map
    );

    return apiResponse;
  }

  Future<ApiResponse> verifyPayment( Map<String, dynamic> data) async {

    final response = await _dio.post("/verify-payment",data: data);

    final apiResponse = ApiResponse.fromJson(
      response.data,
          (data) => data, // simple map
    );

    return apiResponse;
  }


/*  Future<void> submitUser(Map<String, dynamic> data) async {

    try {
      final response =  await _dio.post("/users", data: data);
      print(response.data);
    } catch (e) {
      print("ERROR: $e");
    }
  }*/
}