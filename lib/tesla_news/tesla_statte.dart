
import 'package:debugging/core/utils/enums.dart';

import '../models/tesla_news_model.dart';

class TeslaNewsViewModelState {
  final NetworkState loadState;
  final List<TesLaNews> tesLaNewsList;
  final String? message;
  
  TeslaNewsViewModelState({
    required this.loadState,
    required this.tesLaNewsList,
    required this.message,
  });

  
  factory TeslaNewsViewModelState.initial() {
    return TeslaNewsViewModelState(
      tesLaNewsList: [],
      loadState: NetworkState.loading,
      message: null,
    );
  }
  TeslaNewsViewModelState copyWith({
    NetworkState? loadState,
    List<TesLaNews>? tesLaNewsList,
    String? message,
  }) {
    return TeslaNewsViewModelState(
      loadState: loadState ?? this.loadState,
      tesLaNewsList: tesLaNewsList ?? this.tesLaNewsList,
      message: message ?? this.message,
    );
  }
}