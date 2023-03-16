// ignore_for_file: deprecated_member_use, type_annotate_public_apis

import 'dart:async';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:pharmacy_arrival/app/bloc/auth_bloc.dart';
import 'package:pharmacy_arrival/app/network/models/dto_models/encodable.dart';
import 'package:pharmacy_arrival/app/network/models/dto_models/response/dto_tokens_reaponse.dart';
import 'package:pharmacy_arrival/app/network/repository/global_repository.dart';
import 'package:pharmacy_arrival/app/network/tokens_repository/tokens_repository.dart';

enum NetworkMethod { get, post, put, patch, delete }

class DioWrapper {
  late final TokensRepository tokensRepository;

  final _dio = Dio();

  Future<void> init({
    String baseURL = '',
    required TokensRepository tokensRepository,
    required GlobalRepository globalRepository,
    required AuthBloc loginBloc,
  }) async {
    _dio.options.baseUrl = baseURL;

    _dio.interceptors.requestLock.lock();
    _dio.interceptors.clear();
    _dio.options.connectTimeout = 40000;
    _dio.options.receiveTimeout = 40000;
    _dio.options.sendTimeout = 40000;
    _dio.options.responseType = ResponseType.json;
    this.tokensRepository = tokensRepository;
    _dio.interceptors.addAll([
      AuthInterceptor(
        tokensRepository: tokensRepository,
        baseDio: _dio,
        loginBloc: loginBloc,
      ),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    ]);

    _dio.interceptors.requestLock.unlock();
  }

  Future<void> changeBaseURL({required String url}) async {
    _dio.options.baseUrl = url;
  }

  Future<Response> download(
    String urlPath,
    savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    data,
    Options? options,
  }) async {
    return _dio.download(urlPath, savePath);
  }

  Future<dynamic> sendRequest({
    required String path,
    required NetworkMethod method,
    Encodable? request,
    FormData? formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool isUrlEncoded = true,
  }) async {
    final params = request == null
        ? (formData == null ? null : FormData.fromMap({}))
        : request.toJson();

    switch (method) {
      case NetworkMethod.get:
        final response = await _getRequest(
          path,
          method,
          queryParameters: queryParameters,
          isUrlEncoded: isUrlEncoded,
        );
        return response;
      case NetworkMethod.post:
        final response = formData == null
            ? await _postRequest(
                path,
                method,
                data: params,
                queryParameters: queryParameters,
                options: options,
              )
            : await _postFormData(
                path,
                formData,
                queryParameters: queryParameters,
              );
        return response;
      case NetworkMethod.put:
        final response = await _putRequest(
          path,
          method,
          data: params,
          queryParameters: queryParameters,
        );
        return response;
      case NetworkMethod.delete:
        final response = await _deleteRequest(
          path,
          method,
          data: params,
          queryParameters: queryParameters,
        );
        return response;
      case NetworkMethod.patch:
        final response = await _patchRequest(
          path,
          method,
          data: params,
          queryParameters: queryParameters,
        );
        return response;
      default:
        return null;
    }
  }

  Future<Response<dynamic>> _putRequest(
    String path,
    NetworkMethod method, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response<dynamic>> _deleteRequest(
    String path,
    NetworkMethod method, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response<dynamic>> _postRequest(
    String path,
    NetworkMethod method, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response;
  }

  Future<Response<dynamic>> _patchRequest(
    String path,
    NetworkMethod method, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = _dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response<dynamic>> _postFormData(
    String path,
    FormData data, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response<dynamic>> _getRequest(
    String path,
    NetworkMethod method, {
    Map<String, dynamic>? queryParameters,
    bool isUrlEncoded = true,

    /// disables encoding of URI if false in accordance with header 'application/x-www-form-urlencoded'
  }) async {
    if (!isUrlEncoded && queryParameters != null) {
      // ignore: parameter_assignments
      path = '$path?${_transformQueryParametersToString(queryParameters)}';
    }
    final response =
        _dio.get(path, queryParameters: isUrlEncoded ? queryParameters : null);
    return response;
  }

  String _transformQueryParametersToString(
    Map<String, dynamic> queryParameters,
  ) {
    String query = '';
    queryParameters.forEach((key, value) {
      query += '$key=$value&';
    });
    return query.substring(0, query.length - 1);
  }
}

class AuthInterceptor extends InterceptorsWrapper {
  final TokensRepository tokensRepository;
  final Dio baseDio;
  final Dio dioRefresher;
  final AuthBloc loginBloc;

  AuthInterceptor({
    required this.tokensRepository,
    required this.baseDio,
    required this.loginBloc,
  }) : dioRefresher = Dio(baseDio.options) {
    dioRefresher.interceptors.add(LogInterceptor(requestBody: true));

    ///TODO must be removed
    (dioRefresher.httpClientAdapter as DefaultHttpClientAdapter)
        .onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return null;
    };
  }

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.followRedirects = false;
    options.headers["Authorization"] = 'Bearer ${tokensRepository.accessToken}';
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 302) {
      loginBloc.add(LogOutEvent());
    }
    if (err.response?.statusCode == 401) {
      if (err.requestOptions.path.contains('auth/login')) {
        handler.next(err);
        return;
      }
      baseDio.interceptors.requestLock.lock();
      final tokens = await refreshTokens(tokensRepository.refreshToken);
      if (tokens != null) {
        tokensRepository.save(tokens.accessToken);
        err.requestOptions.headers["Authorization"] =
            'Bearer ${tokens.accessToken}';
        final lastResponse = await dioRefresher.fetch(err.requestOptions);
        handler.resolve(lastResponse);
        baseDio.interceptors.requestLock.unlock();
        return;
      }
    }
    handler.next(err);
  }

  Future<DTOTokensResponse?> refreshTokens(String refreshToken) async {
    try {
      final response = await dioRefresher
          .get('auth/refresh', queryParameters: {"token": refreshToken});
      return DTOTokensResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      if (e is DioError && e.response?.statusCode == 404) {
        loginBloc.add(LogOutEvent());
      }
    }
    return null;
  }
}
