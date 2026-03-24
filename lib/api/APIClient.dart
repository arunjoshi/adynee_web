import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
      : dio = Dio(BaseOptions(
    baseUrl: "https://your-api.execute-api.eu-north-1.amazonaws.com/dev",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  )) {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add headers if needed
          options.headers["Content-Type"] = "application/json";
          return handler.next(options);
        },

        onResponse: (response, handler) {
          // ✅ Handle success response globally
          final res = response.data;

          if (res['status'] == 'error') {
            return handler.reject(
              DioException(
                requestOptions: response.requestOptions,
                response: response,
                error: res['message'],
              ),
            );
          }

          return handler.next(response);
        },

        onError: (DioException e, handler) {
          // ✅ Centralized error handling

          String message = "Something went wrong";

          if (e.response != null) {
            message = e.response?.data['message'] ?? message;
          } else if (e.type == DioExceptionType.connectionTimeout) {
            message = "Connection timeout";
          } else if (e.type == DioExceptionType.connectionError) {
            message = "No internet connection";
          }

          print("GLOBAL ERROR: $message");

          return handler.next(
            DioException(
              requestOptions: e.requestOptions,
              error: message,
            ),
          );
        },
      ),
    );
  }
}