import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart' as fData;
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/service/network/repo/api_repository.dart';

import '../../common/common_methods.dart';
import '../../core/route/app_router.dart';

class ApiCall implements ApiRepository {
  final Dio _dio = _buildDio();

  static Dio _buildDio({
    Duration connectTimeout = const Duration(seconds: 20),
    Duration receiveTimeout = const Duration(seconds: 30),
  }) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        validateStatus: (status) => true,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('${options.method} ${options.uri}');
          log('Headers: ${options.headers}');
          if (options.queryParameters.isNotEmpty) {
            log('Query: ${options.queryParameters}');
          }
          if (options.data != null) log('Body: ${options.data}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          log(' ${response.statusCode} ${response.requestOptions.uri}');
          log('Response: ${response.data}');
          if(response.statusCode == 401){
            HiveStorageService.eraseAllData();
            AppRouter.router.go(RouteConstant.login);
            return;
          }
          handler.next(response);
        },
        onError: (e, handler) {
          log(' DioError: ${e.message}');
          if (e.response != null) {
            log('Status: ${e.response?.statusCode}');
            log('Data: ${e.response?.data}');
          }
          handler.next(e);
        },
      ),
    );
    // dio.interceptors.add(NetworkInterceptor());
    return dio;
  }

  static Map<String, String> _headers({String? token}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null && token.trim().isNotEmpty) {
      headers['Authorization'] = 'JWT $token';
    }
    return headers;
  }

  static DioException _wrapDioError(DioException e) => e;

  //  GET
  @override
  Future<Response<T>> getRequest<T>({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? extraHeaders,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final hdrs = {
        ..._headers(token: token),
        if (extraHeaders != null) ...extraHeaders,
      };

      final opts = (options ?? Options()).copyWith(
        headers: hdrs,
        validateStatus: (status) => true,
      );

      final response = await _dio.get<T>(
        endPoint,
        queryParameters: queryParameters,
        options: opts,
        cancelToken: cancelToken,
      );

      return response;
    } catch (e) {
      log('Error');
      // If some other unexpected error occurs (like network failure)
      return Future.error(e);
    }
  }

  //  POST
  @override
  Future<Response<T>> postRequest<T>({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, String>? extraHeaders,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final hdrs = {
        ..._headers(token: token),
        if (data is fData.FormData) 'Content-Type': 'multipart/form-data',
        if (extraHeaders != null) ...extraHeaders,
      };
      log('End Point  $endPoint');
      log('Headers  $hdrs');
      return await _dio.post<T>(
        endPoint,
        queryParameters: queryParameters,
        data: data,
        options: (options ?? Options()).copyWith(headers: hdrs),
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      return Future.error(_wrapDioError(e));
    }
  }

  //  PUT
  @override
  Future<Response<T>> putRequest<T>({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, String>? extraHeaders,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final hdrs = {
        ..._headers(token: token),
        if (data is FormData) 'Content-Type': 'multipart/form-data',
        if (extraHeaders != null) ...extraHeaders,
      };
      return await _dio.put<T>(
        endPoint,
        queryParameters: queryParameters,
        data: data,
        options: (options ?? Options()).copyWith(headers: hdrs),
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      return Future.error(_wrapDioError(e));
    }
  }

  //  DELETE
  @override
  Future<Response<T>> deleteRequest<T>({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, String>? extraHeaders,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final hdrs = {
        ..._headers(token: token),
        if (extraHeaders != null) ...extraHeaders,
      };
      return await _dio.delete<T>(
        endPoint,
        queryParameters: queryParameters,
        data: data,
        options: (options ?? Options()).copyWith(headers: hdrs),
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      return Future.error(_wrapDioError(e));
    }
  }
  // PATCH
  @override
  Future<Response<T>> patchRequest<T>({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, String>? extraHeaders,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final hdrs = {
        ..._headers(token: token),
        if (data is FormData) 'Content-Type': 'multipart/form-data',
        if (extraHeaders != null) ...extraHeaders,
      };

      return await _dio.patch<T>(
        endPoint,
        queryParameters: queryParameters,
        data: data,
        options: (options ?? Options()).copyWith(headers: hdrs),
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      return Future.error(_wrapDioError(e));
    }
  }
}
