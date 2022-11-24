import 'package:debugging/core/utils/enums.dart';
import 'package:debugging/news/news_view_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/repository/news_repository.dart';

class NewsViewModel extends StateNotifier<NewsViewState> {
  NewsViewModel(this._postRepository) : super(NewsViewState.initial());
  final PostRepository _postRepository;

  void fetchPosts() async {
    try {
      final response = await _postRepository.getPosts();
      if (response.success) {
        state =
            state.copyWith(posts: response.data, status: NetworkState.success);
      } else {
        state = state.copyWith(
          status: NetworkState.error,
          errorMessage: response.message,
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: NetworkState.error,
        errorMessage: e.toString(),
      );
    }
  }
}

final newViewModel = StateNotifierProvider<NewsViewModel, NewsViewState>(
  (ref) => NewsViewModel(ref.read(postRepository)),
);


//Screen A  -X     State X
//Screen B  -X
//Screen C -X