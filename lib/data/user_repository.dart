import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../models/ModelProvider.dart';

class UserRepository {
  Future<List<User?>> queryListItems() async {
    try {
      final request = ModelQueries.list(User.classType);
      final response = await Amplify.API.query(request: request).response;

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
}
