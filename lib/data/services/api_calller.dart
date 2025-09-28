import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:todo_app/ui/controllers/auth_controller.dart';

class ApiCalller {
  static final Logger _log = Logger();

  static Future<ApiResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      _requestLogger(url);
      Response response = await get(
        uri,
        headers: {'token': AuthController.userToken ?? ""},
      );
      _responseLogger(url, response.statusCode, response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          isuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return ApiResponse(
          isuccess: false,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
          errorMessage: jsonDecode(response.body)['data'],
        );
      }
    } on Exception catch (e) {
      return ApiResponse(
        isuccess: false,
        statusCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<ApiResponse> postRequest({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _requestLogger(url, body: body);
      Response response = await post(
        uri,
        headers: {
          'content-type': 'application/json',
          'token': AuthController.userToken ?? '',
        },
        body: jsonEncode(body),
      );
      _responseLogger(url, response.statusCode, response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          isuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return ApiResponse(
          isuccess: false,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
          errorMessage: jsonDecode(response.body)['data'],
        );
      }
    } on Exception catch (e) {
      return ApiResponse(
        isuccess: false,
        statusCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  static void _requestLogger(String url, {Map<String, dynamic>? body}) {
    _log.i(
      "URL=> $url\n"
      "body=> $body",
    );
  }

  static void _responseLogger(String url, int statusCode, Response response) {
    _log.i(
      "URL=> $url\n"
      "StatusCode=> ${response.statusCode}"
      "body=> ${response.body}",
    );
  }
}

class ApiResponse {
  final bool isuccess;
  final int statusCode;
  final dynamic responseData;
  final String? errorMessage;

  ApiResponse({
    required this.isuccess,
    required this.statusCode,
    required this.responseData,
    this.errorMessage = "Something Went Wrong!",
  });
}
