import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../models/ModelProvider.dart';
import 'graphQL_helper/graphQL_helper.dart';

class NoticeRepository {
  final GraphQLHelper _graphQLHelper = GraphQLHelper();

  Future<List<PublicNotice?>> queryListItems() async {
    try {
      final request = ModelQueries.list(PublicNotice.classType);
      final response = await Amplify.API
          .query(request: request)
          .response;

      final noticeList = response.data?.items;
      if (noticeList == null) {
        safePrint('데이터가 없습니다. ${response.errors}');
        return [];
      }
      return noticeList;
    } on ApiException catch (e) {
      safePrint('데이터를 가져오는데 실패했습니다. ${e.message}');
      return [];
    }
  }

}
