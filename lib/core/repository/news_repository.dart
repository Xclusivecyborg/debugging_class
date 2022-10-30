// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import '../../models/posts_model.dart';

class PostsRepository {
  final Dio _dio;

  PostsRepository(this._dio);

  Future<ApiResponse<List<Posts>>> getPosts() async {
  
      final response =
          await _dio.get("http://jsonplaceholder.typicode.com/posts");
      if (response.statusCode == 200) {

        List data = response.data;
        List<Posts> posts = data.map((e) => Posts.fromJson(e)).toList();

        return ApiResponse<List<Posts>>(
          success: true,
          data: posts,
          message: "Posts fetched successfully",
        );
      }
      return ApiResponse(
        success: false,
        data: null,
        message: "An error occurred",
      );
   
  }
}



class ApiResponse<T> {
  final bool success;
  final T? data;
  final String message;
  ApiResponse({
    required this.success,
    required this.data,
    required this.message,
  });
}
