// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:debugging/core/utils/enums.dart';
import 'package:debugging/models/posts_model.dart';

class NewsViewState {
  final NetworkState status;
  final List<Posts> posts;
  final String? errorMessage;

  NewsViewState({
    required this.status,
    required this.posts,
    this.errorMessage,
  });

  factory NewsViewState.initial() {
    return NewsViewState(
      posts: [],
      status: NetworkState.loading,
    );
  }

  NewsViewState copyWith({
    List<Posts>? posts,
    NetworkState? status,
    String? errorMessage,
  }) {
    return NewsViewState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
