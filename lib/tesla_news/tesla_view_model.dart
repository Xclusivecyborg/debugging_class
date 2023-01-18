import 'package:debugging/core/repository/news_repository.dart';
import 'package:debugging/core/utils/enums.dart';
import 'package:debugging/tesla_news/tesla_statte.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeslaNewsViewModel extends StateNotifier<TeslaNewsViewModelState> {
  TeslaNewsViewModel(this._postRepository)
      : super(TeslaNewsViewModelState.initial());

  final PostRepository _postRepository;

  void fetchTesLaNews() async {
    try {
      final response = await _postRepository.getTesLaNews();
      if (response.success) {
        state = state.copyWith(
          tesLaNewsList: response.data,
          loadState: NetworkState.success,
        );
        return;
      }
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
      );
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );
    }
  }

}

final teslaNewsViewModel = StateNotifierProvider.autoDispose<TeslaNewsViewModel,
    TeslaNewsViewModelState>(
  (_) => TeslaNewsViewModel(
    _.read(
      postRepository,
    ),
  ),
);
