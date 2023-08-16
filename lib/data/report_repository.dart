import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:seoul_forest_web_admin/data/report_mutations.dart';

import '../models/ModelProvider.dart';
import 'graphQL_helper/graphQL_helper.dart';

class ReportRepository {
  final GraphQLHelper _graphQLHelper = GraphQLHelper();
  Future<List<Report?>> queryListItems() async {
    try {
      final request = ModelQueries.list(Report.classType);
      final response = await Amplify.API.query(request: request).response;

      final reportList = response.data?.items;
      if (reportList == null) {
        safePrint('데이터가 없습니다. ${response.errors}');
        return [];
      }
      return reportList;
    } on ApiException catch (e) {
      safePrint('데이터를 가져오는데 실패했습니다. ${e.message}');
      return [];
    }
  }

  Future<bool> deleteReport(String reportID) async {
    var request = await _graphQLHelper.buildRequest(
      document: ReportMutations.deleteReport,
      variables: {
        'id': reportID,
      },
      decodePath: 'deleteReport',
      modelType: Post.classType,
    );
    var response = await _graphQLHelper.processRequest(
        request, GraphQLHelperRequestType.mutation);
    return response.data != null;
  }
}
