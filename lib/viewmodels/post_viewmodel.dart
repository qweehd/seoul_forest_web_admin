import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:seoul_forest_web_admin/data/post_repository.dart';
import '../models/ModelProvider.dart';

class PostViewModel extends ChangeNotifier {
  final PostRepository _postRepository;

  PostViewModel({required PostRepository postRepository})
      : _postRepository = postRepository;

  List<Post> _postItems = [];
  List<Post> get postItems => _postItems;

  bool postLoading = false;

  Future<void> queryPostItems() async {
    postLoading = true;
    Future.microtask(() => notifyListeners());
    final postList = await _postRepository.queryListItems();
    _postItems = postList.map((e) => e as Post).toList();
    _postItems.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    postLoading = false;
    Future.microtask(() => notifyListeners());
  }

  Future<void> deletePost(String postID) async {
    if (await _postRepository.deletePost(postID)) {
      postItems.removeWhere((post) => post.id == postID);
      notifyListeners();
    } else {
      safePrint('Error deleting Post');
      notifyListeners();
    }
  }

  void deletePostByID(Map<String, bool> checkedMap) {
checkedMap.forEach((key, value) async {
      if (value) {
        await deletePost(key);
      }
    });
  }
}
