import 'package:dio/dio.dart';

abstract class ApiRepository {
  Future<Response<T>> getRequest<T>({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? extraHeaders,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<Response<T>> postRequest<T>({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, String>? extraHeaders,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<Response<T>> postMultipartRequest<T>({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
    required FormData data,
    Map<String, String>? extraHeaders,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<Response<T>> putRequest<T>({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, String>? extraHeaders,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<Response<T>> deleteRequest<T>({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, String>? extraHeaders,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<Response<T>> patchRequest<T>({
    required String endPoint,
    String? token,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, String>? extraHeaders,
    Options? options,
    CancelToken? cancelToken,
  });
}