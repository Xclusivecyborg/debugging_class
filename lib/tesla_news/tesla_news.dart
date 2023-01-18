import 'package:debugging/core/utils/enums.dart';
import 'package:debugging/tesla_news/tesla_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/tesla_news_model.dart';

class TeslaNewsView extends ConsumerStatefulWidget {
  const TeslaNewsView({super.key});

  @override
  ConsumerState<TeslaNewsView> createState() => _TeslaNewsViewState();
}

class _TeslaNewsViewState extends ConsumerState<TeslaNewsView> {
  @override
  void initState() {
    ref.read(teslaNewsViewModel.notifier).fetchTesLaNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tesla news")),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(teslaNewsViewModel);
          if (state.loadState == NetworkState.loading) {
            return Center(child: const CircularProgressIndicator());
          } else if (state.loadState == NetworkState.error) {
            return Center(
              child: Text(state.message ?? "An error occurred"),
            );
          }
          return ListView.builder(
            itemCount: state.tesLaNewsList.length,
            itemBuilder: (context, index) {
              TesLaNews news = state.tesLaNewsList[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(news.urlToImage ?? ""),
                ),
                title: Text(news.title ?? ""),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(news.content ?? ""),
                    Text("${news.author}"),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
