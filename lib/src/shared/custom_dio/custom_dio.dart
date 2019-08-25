import 'package:dio/dio.dart';
import 'package:smart_place_app/src/shared/custom_dio/interceptors.dart';

import '../constants.dart';

class CustomDio extends Dio{
  CustomDio () {
    options.baseUrl = BASE_URL;
    options.headers["Authorization"] = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI3YmVmMmE0NC1lMzVhLTQxNmQtOWEwNS0zZTJhMzM5YzNlMTMiLCJleHAiOjE1Njc2MDE0NTZ9.QweAnOaJ946PRaVP8o0ZYjl4_2Kam8qjz3cidfvtkSU";
    interceptors.add(CustomInterceptors());
    // options.connectTimeout = 10000;
  }
}