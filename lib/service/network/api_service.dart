import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart' as fData;
import 'package:healing/core/route/route_constant/route_constant.dart';
import 'package:healing/core/storage/hive_storage_service.dart';
import 'package:healing/service/network/repo/api_repository.dart';

import 'dart:async';
import 'package:get/get.dart' hide Response, FormData;
import 'package:healing/controller/auth_controller.dart';
import 'package:healing/service/network/api_constant/api_constant.dart';

import '../../core/route/app_router.dart';

class ApiCall implements ApiRepository {
  final Dio _dio = _buildDio();

  static bool _isRefreshing = false;
  static final List<Completer<bool>> _refreshCompleters = [];

  static Future<bool> _refreshToken() async {
    if (_isRefreshing) {
      final completer = Completer<bool>();
      _refreshCompleters.add(completer);
      return completer.future;
    }

    _isRefreshing = true;

    try {
      final authController = Get.isRegistered<AuthController>()
          ? Get.find<AuthController>()
          : Get.put(AuthController());
      final success = await authController.refreshToken();

      for (final completer in _refreshCompleters) {
        completer.complete(success);
      }
      _refreshCompleters.clear();
      return success;
    } catch (e) {
      log('Error during interceptor token refresh: $e');
      for (final completer in _refreshCompleters) {
        completer.complete(false);
      }
      _refreshCompleters.clear();
      return false;
    } finally {
      _isRefreshing = false;
    }
  }

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
        onResponse: (response, handler) async {
          log(' ${response.statusCode} ${response.requestOptions.uri}');
          log('Response: ${response.data}');

          if (response.statusCode == 401) {
            final path = response.requestOptions.path;
            if (path.contains('refresh-token') || path.contains(ApiConstant.refreshToken)) {
              log('Token refresh request returned 401 in onResponse, logging out...');
              await HiveStorageService.eraseAllData();
              AppRouter.router.go(RouteConstant.login);
              handler.next(response);
              return;
            }

            log('Detected 401 status code in onResponse, attempting to refresh token...');
            final isRefreshed = await _refreshToken();
            if (isRefreshed) {
              log('Token refreshed successfully. Retrying original request...');
              final options = response.requestOptions;
              final newToken = HiveStorageService.getUserToken();
              if (newToken != null && newToken.isNotEmpty) {
                options.headers['Authorization'] = 'JWT $newToken';
              }

              try {
                final retryResponse = await dio.request(
                  options.path,
                  data: options.data,
                  queryParameters: options.queryParameters,
                  cancelToken: options.cancelToken,
                  options: Options(
                    method: options.method,
                    headers: options.headers,
                    extra: options.extra,
                    responseType: options.responseType,
                    contentType: options.contentType,
                    validateStatus: options.validateStatus,
                    receiveTimeout: options.receiveTimeout,
                    sendTimeout: options.sendTimeout,
                  ),
                );
                handler.resolve(retryResponse);
                return;
              } catch (e) {
                log('Failed to retry request after token refresh: $e');
                handler.next(response);
                return;
              }
            } else {
              log('Token refresh failed. Redirecting to login...');
              await HiveStorageService.eraseAllData();
              AppRouter.router.go(RouteConstant.login);
              handler.next(response);
              return;
            }
          }

          handler.next(response);
        },
        onError: (e, handler) async {
          log(' DioError: ${e.message}');
          if (e.response != null) {
            log('Status: ${e.response?.statusCode}');
            log('Data: ${e.response?.data}');

            if (e.response?.statusCode == 401) {
              final path = e.requestOptions.path;
              if (path.contains('refresh-token') || path.contains(ApiConstant.refreshToken)) {
                log('Token refresh request failed with 401 in onError, logging out...');
                await HiveStorageService.eraseAllData();
                AppRouter.router.go(RouteConstant.login);
                handler.next(e);
                return;
              }

              log('Detected 401 in onError, attempting to refresh token...');
              final isRefreshed = await _refreshToken();
              if (isRefreshed) {
                final options = e.requestOptions;
                final newToken = HiveStorageService.getUserToken();
                if (newToken != null && newToken.isNotEmpty) {
                  options.headers['Authorization'] = 'JWT $newToken';
                }

                try {
                  final retryResponse = await dio.request(
                    options.path,
                    data: options.data,
                    queryParameters: options.queryParameters,
                    cancelToken: options.cancelToken,
                    options: Options(
                      method: options.method,
                      headers: options.headers,
                      extra: options.extra,
                      responseType: options.responseType,
                      contentType: options.contentType,
                      validateStatus: options.validateStatus,
                      receiveTimeout: options.receiveTimeout,
                      sendTimeout: options.sendTimeout,
                    ),
                  );
                  handler.resolve(retryResponse);
                  return;
                } catch (retryError) {
                  log('Failed to retry request after token refresh in onError: $retryError');
                  handler.next(e);
                  return;
                }
              } else {
                log('Token refresh failed in onError. Redirecting to login...');
                await HiveStorageService.eraseAllData();
                AppRouter.router.go(RouteConstant.login);
                handler.next(e);
                return;
              }
            }
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

  @override
  Future<Response<T>> postMultipartRequest<T>({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
    required FormData data,
    Map<String, String>? extraHeaders,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final hdrs = {
        ..._headers(token: token),
        'Content-Type': 'multipart/form-data',
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
