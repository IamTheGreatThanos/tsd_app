import 'package:dio/dio.dart';

class SideDioWrapper {
  final Dio _dio = Dio();

  Dio get dio => _dio;

  SideDioWrapper() {
    _dio.interceptors.add(LogInterceptor(requestBody: true));
    _dio.options.connectTimeout = 40000;
    _dio.options.receiveTimeout = 40000;
    _dio.options.sendTimeout = 40000;
    _dio.options.responseType = ResponseType.json;
  }
}
