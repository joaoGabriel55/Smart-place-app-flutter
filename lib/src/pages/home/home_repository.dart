import 'package:dio/dio.dart';
import 'package:smart_place_app/src/shared/custom_dio/custom_dio.dart';
import 'package:smart_place_app/src/shared/models/device.dart';

class HomeRepository {
  final CustomDio _client;

  HomeRepository(this._client);

  Future<List<Device>> getDeviceHistory() async {
    try {
      var response = await _client.get("/message");
      return (response.data as List).map((item)=> Device.fromJson(item)).toList();
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<int> createPost(Map<String,dynamic>data)async{
    try {
      var response = await _client.post('/message', data:data);
      return response.statusCode;
    } on DioError catch (e) {
      throw (e.message);
    }
  }

}