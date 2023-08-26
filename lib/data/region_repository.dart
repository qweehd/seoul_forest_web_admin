import 'package:seoul_forest_web_admin/data/graphQL_helper/graphQL_helper.dart';
import 'package:seoul_forest_web_admin/data/region_queries.dart';

import '../models/ModelProvider.dart';

class RegionRepository {
  final GraphQLHelper _graphQLHelper = GraphQLHelper();

  Future<List<Country>> fetchAllCountries() async {
    var request = await _graphQLHelper.buildRequest(
      document: RegionQueries.getAllCountries,
      decodePath: 'listCountries',
      modelType: Country.classType,
      variables: {},
    );

    var response = await _graphQLHelper.processRequest(
        request, GraphQLHelperRequestType.query);

    List<Country> countryList = [];

    if (response.data != null) {
      countryList = response.data['items']
          .map<Country>((e) => Country.fromJson(e))
          .toList();
    }

    return countryList;
  }
}
