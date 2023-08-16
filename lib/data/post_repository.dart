import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:seoul_forest_web_admin/data/post_mutations.dart';

import '../models/ModelProvider.dart';
import 'graphQL_helper/graphQL_helper.dart';

class PostRepository {
  final GraphQLHelper _graphQLHelper = GraphQLHelper();

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

  Future<bool> deletePost(String postID) async {
    var request = await _graphQLHelper.buildRequest(
      document: PostMutations.deletePost,
      variables: {
        'id': postID,
      },
      decodePath: 'deletePost',
      modelType: Post.classType,
    );
    var response = await _graphQLHelper.processRequest(
        request, GraphQLHelperRequestType.mutation);
    return response.data != null;
  }
}
