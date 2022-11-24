import 'package:debugging/core/config/exception/app_exception.dart';
import 'package:debugging/core/config/helpers/auth_strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/posts_model.dart';
import '../config/response/api_response.dart';
import '../services/providers.dart';

abstract class PostRepository {
  Future<ApiResponse<List<Posts>>> getPosts();
}

class PostsRepositoryImpl implements PostRepository {
  final Dio _dio;

  PostsRepositoryImpl(this._dio);

  @override
  Future<ApiResponse<List<Posts>>> getPosts() async {
    try {
      final response = await _dio.get(
        '/posts',
      );
      List data = response.data;
      List<Posts> posts = data.map((e) => Posts.fromJson(e)).toList();
      return ApiResponse<List<Posts>>(
        success: true,
        data: posts,
        message: "Posts fetched successfully",
      );
    } on DioError catch (e) {
      return AppException.handleError(e);
    }
  }
}

final postRepository = Provider<PostRepository>(
  (ref) => PostsRepositoryImpl(
    ref.read(dioProvider),
  ),
);
