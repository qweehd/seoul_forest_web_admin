import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:seoul_forest_web_admin/data/public_notice_mutations.dart';

import '../models/ModelProvider.dart';
import 'graphQL_helper/graphQL_helper.dart';

class PublicNoticeRepository {
  final GraphQLHelper _graphQLHelper = GraphQLHelper();

  Future<List<PublicNotice?>> queryListItems() async {
    try {
      final request = ModelQueries.list(PublicNotice.classType);
      final response = await Amplify.API.query(request: request).response;

      final publicNoticeList = response.data?.items;
      if (publicNoticeList == null) {
        safePrint('데이터가 없습니다. ${response.errors}');
        return [];
      }
      return publicNoticeList;
    } on ApiException catch (e) {
      safePrint('데이터를 가져오는데 실패했습니다. ${e.message}');
      return [];
    }
  }

  Future<bool> deletePublicNotice(String publicNoticeID) async {
    var request = await _graphQLHelper.buildRequest(
      document: PublicNoticeMutations.deletePublicNotice,
      variables: {
        'id': publicNoticeID,
      },
      decodePath: 'deletePublicNotice',
      modelType: PublicNotice.classType,
    );
    var response = await _graphQLHelper.processRequest(
        request, GraphQLHelperRequestType.mutation);
    return response.data != null;
  }

  Future<bool> createPublicNotice(PublicNotice publicNotice) async {
    var request = await _graphQLHelper.buildRequest(
      document: PublicNoticeMutations.createPublicNotice,
      variables: {
        'cityID': publicNotice.city!.id,
        'content': publicNotice.content,
        'countryID': publicNotice.country!.id,
        'nationalScope': publicNotice.nationalScope,
        'sortNum': publicNotice.sortNum,
        'title': publicNotice.title,
      },
      decodePath: 'createPublicNotice',
      modelType: PublicNotice.classType,
    );
    var response = await _graphQLHelper.processRequest(
        request, GraphQLHelperRequestType.mutation);

    return response.data != null;
  }
}
