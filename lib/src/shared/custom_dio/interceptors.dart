import 'package:dio/dio.dart';

// Like a filter
class CustomInterceptors extends InterceptorsWrapper{
  
  @override
  onRequest(RequestOptions options){
    print("Request[${options.method}][${options.headers}] => Path: ${options.path}");
    return options;
  }

  @override
  onResponse(Response response){
    print("Response[${response.statusCode}] => Path: ${response.request.path}");
    return response;
  }

  @override
  onError(DioError error){
    print("Error[${error.response.statusCode}] => Path: ${error.request.path}");
    return error;
  }

}