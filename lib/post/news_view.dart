import 'package:debugging/core/utils/enums.dart';
import 'package:debugging/post/news_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///A staterful widget with a WIDGETREF OBJECT
class DebugView extends ConsumerStatefulWidget {
  const DebugView({Key? key}) : super(key: key);

  @override
  ConsumerState<DebugView> createState() => _DebugViewState();
}

class _DebugViewState extends ConsumerState<DebugView> {
  late NewsViewModel _model;

  @override
  void initState() {
    super.initState();
    _model = ref.read(newViewModel.notifier);
    _model.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(newViewModel);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Debugging",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: state.status == NetworkState.loading
          ? const Center(child: CircularProgressIndicator())
          : state.status == NetworkState.error
              ? Center(
                  child: Text(state.errorMessage ?? "An error occurred"),
                )
              : ListView.builder(
                  itemCount: state.posts.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return ListTile(
                      leading: const CircleAvatar(),
                      title: Text(post.title ?? ""),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.body ?? ""),
                          Text("${post.userId}"),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}




//GET
//https://newsapi.org
//https://newsapi.org/v2/everything?q=tesla&from=2022-12-18&sortBy=publishedAt&apiKey=c5810690c39b416d8b642f75e41612e9
///
///
///Baseurl - https://newsapi.org
///Path -/v2/everything
///QueryParameter -?q=tesla&from=2022-12-18&sortBy=publishedAt&apiKey=c5810690c39b416d8b642f75e41612e9
///
///{

///}
///
///
// Map<String,dynamic> queryParameters ={
//   "q": "tesla",
//   "from": "2022-12-18",
//   "sortBy": "publishedAt",
//   "apiKey": "c5810690c39b416d",
// };