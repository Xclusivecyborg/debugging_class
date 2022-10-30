import 'package:debugging/core/repository/news_repository.dart';
import 'package:debugging/models/posts_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DebugView extends StatefulWidget {
  const DebugView({Key? key}) : super(key: key);

  @override
  State<DebugView> createState() => _DebugViewState();
}

class _DebugViewState extends State<DebugView> {
  List<Posts> posts = [];
  final postRepository = PostsRepository(Dio());
  NetworkState stateOfNetwork = NetworkState.loading;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  getPosts() async {
    final res = await postRepository.getPosts();
    if (res.success) {
      posts = res.data!;
      stateOfNetwork = NetworkState.success;
      setState(() {});
      return;
    }
    errorMessage = res.message;
    stateOfNetwork = NetworkState.error;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Debugging",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: stateOfNetwork == NetworkState.success
          ? const Center(child: CircularProgressIndicator.adaptive())
          : stateOfNetwork == NetworkState.error
              ? Center(
                  child: Text(errorMessage),
                )
              : ListView.builder(
                  itemCount: posts.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return ListTile(
                      leading: const CircleAvatar(),
                      title: Text(post.title ?? ""),
                      subtitle: Column(
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

enum NetworkState { success, error, loading }



//200