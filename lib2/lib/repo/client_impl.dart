import 'package:advansys_project/repo/request_interceptor.dart';
import 'package:dio/dio.dart';
import '../helpers/states/api_values.dart';
import 'client.dart';

class ClientImpl<T, E> extends RequestInterceptor<T, E> implements Client<T, E> {
  Dio? _dio;

  ClientImpl(this.specialKey) {
    specialKey = this.specialKey;
    _dio = Dio()..interceptors.add(this);
  }


  @override
  Future<E?> callPost(
      {required Map<String, dynamic> data,
      required ApiValues apiValues}) async {
    Response response = await _dio!.post(apiValues.getUrl, data: data);
    return response.data as E?;
  }

  @override
  String specialKey;
}
