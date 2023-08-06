import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../models/ModelProvider.dart';

class PostRepository {
  Future<List<Post?>> queryListItems() async {
    try {
      final request = ModelQueries.list(Post.classType);
      final response = await Amplify.API.query(request: request).response;

      final postList = response.data?.items;
      if (postList == null) {
        safePrint('데이터가 없습니다. ${response.errors}');
        return [];
      }
      return postList;
    } on ApiException catch (e) {
      safePrint('데이터를 가져오는데 실패했습니다. ${e.message}');
      return [];
    }
  }
}
