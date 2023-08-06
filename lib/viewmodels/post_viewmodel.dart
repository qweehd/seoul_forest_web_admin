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

  Future<void> queryPostItems() async {
    final postList = await _postRepository.queryListItems();
    safePrint('postList: $postList');
    _postItems = postList.map((e) => e as Post).toList();
    notifyListeners();
  }

}
