import 'package:debugging/core/config/helpers/auth_strings.dart';
import 'package:debugging/core/utils/interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider.family((ref, NetworkType val) {
  final dio = Dio();

  if (val == NetworkType.tesla) {
    dio.options.baseUrl = AuthStrings.newBaseUrl;
    dio.interceptors.add(AppInterceptor());
    return dio;
  }
  dio.options.baseUrl = AuthStrings.baseUrl;
  return dio;
});

enum NetworkType { post, tesla }

final dioProvide = Provider<Dio>((ref) {
  final dio = Dio();
  dio.interceptors.add(AppInterceptor());
  return dio;
});


