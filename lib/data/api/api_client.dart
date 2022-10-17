import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl; //comes from getConnect
    timeout = const Duration(seconds: 30); //comes from getConnect
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Autorization': 'Bearer $token',
    };
  }

  //response from getX package
  Future<Response> getData(
    String uri,
  ) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      debugPrint("exception : $e");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
