import 'package:debugging/core/config/helpers/auth_strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider((_) {
  final dio = Dio();
  dio.options.baseUrl = AuthStrings.baseUrl;
  dio.options.headers = {
    "Content-Type": "application/json",
    "accept": "application/json",
  };
  return dio;
});
