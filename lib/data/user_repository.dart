import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:seoul_forest_web_admin/data/user_mutations.dart';

import '../models/ModelProvider.dart';
import 'graphQL_helper/graphQL_helper.dart';

class UserRepository {
  final GraphQLHelper _graphQLHelper = GraphQLHelper();
  Future<List<User?>> queryListItems() async {
    try {
      final request = ModelQueries.list(User.classType);
      final response = await Amplify.API
          .query(request: request)
          .response;

      final userList = response.data?.items;
      if (userList == null) {
        safePrint('데이터가 없습니다. ${response.errors}');
        return [];
      }
      return userList;
    } on ApiException catch (e) {
      safePrint('데이터를 가져오는데 실패했습니다. ${e.message}');
      return [];
    }
  }

  Future<bool> deleteUser(String userID) async {
    var request = await _graphQLHelper.buildRequest(
      document: UserMutations.deleteUser,
      variables: {
        'id': userID,
      },
      decodePath: 'deleteUser',
      modelType: User.classType,
    );
    var response = await _graphQLHelper.processRequest(
        request, GraphQLHelperRequestType.mutation);
    return response.data != null;
  }
}