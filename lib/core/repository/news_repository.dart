import 'package:debugging/core/config/exception/app_exception.dart';
import 'package:debugging/core/config/helpers/auth_strings.dart';
import 'package:debugging/models/tesla_news_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/posts_model.dart';
import '../config/response/api_response.dart';
import '../services/providers.dart';

abstract class PostRepository {
  Future<ApiResponse<List<Posts>>> getPosts();
  Future<ApiResponse<List<TesLaNews>>> getTesLaNews();
}

class PostsRepositoryImpl implements PostRepository {
  final Dio _dio;
  final Dio _teslaDio;

  PostsRepositoryImpl(
    this._dio,
    this._teslaDio,
  );

  @override
  Future<ApiResponse<List<Posts>>> getPosts() async {
    try {
      final response = await _dio.get(
        AuthStrings.postPath,
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

  @override
  Future<ApiResponse<List<TesLaNews>>> getTesLaNews() async {
    try {
      final response = await _teslaDio.get(
        AuthStrings.tesLaPath,
        queryParameters: {
          "q": "tesla",
          "from": "2022-12-18",
          "sortBy": "publishedAt",
        },
      );
      List data = response.data["articles"];
      List<TesLaNews> posts = data.map((e) => TesLaNews.fromJson(e)).toList();
      return ApiResponse<List<TesLaNews>>(
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
    ref.read(dioProvider(NetworkType.post)),
    ref.read(dioProvider(NetworkType.tesla)),
  ),
);
