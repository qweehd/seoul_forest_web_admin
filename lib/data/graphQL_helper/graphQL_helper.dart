import 'package:amplify_flutter/amplify_flutter.dart';

class GraphQLHelper {
  /* Request 만들기 */
  Future<GraphQLRequest<T>> buildRequest<T>(
      {required String document,
        required Map<String, dynamic> variables,
        required String decodePath,
        required ModelType modelType}) async {
    return GraphQLRequest<T>(
      document: document,
      variables: variables,
      decodePath: decodePath,
      modelType: modelType,
    );
  }

  /* Request 작업 */
  Future<GraphQLResponse<T>> processRequest<T>(
      GraphQLRequest<T> request, GraphQLHelperRequestType operationType) async {
    safePrint('########## 쿼리 시작 ##########');
    safePrint('###### 요청: ${request.decodePath} ######');
    safePrint('###### 작업 타입: $operationType ######');

    try {
      dynamic operation;
      if (operationType == GraphQLHelperRequestType.query) {
        safePrint('쿼리 진행 중...');
        operation = Amplify.API.query(request: request);
      } else if (operationType == GraphQLHelperRequestType.mutation) {
        safePrint('뮤테이션 진행 중...');
        operation = Amplify.API.mutate(request: request);
      }
      safePrint('###### 요청 응답 도착 ######');

      var response = await operation.response;

      safePrint('###### 데이터: ${response.data} ######');

      if (response.data == null) {
        safePrint('데이터 = null, 에러 : ${response.errors}');
        if (T is List || T is PaginatedResult) {
          response.data = [];
        }
      }

      safePrint('########### 쿼리 종료 ###########');
      return response;
    } on ApiException catch (e) {
      safePrint('Api예외 발생: $e');
      safePrint('########### 쿼리 종료 ###########');
      rethrow;
    } catch (e) {
      safePrint('예외 발생: $e');
      safePrint('########### 쿼리 종료 ###########');
      rethrow;
    }
  }
}

enum GraphQLHelperRequestType { query, mutation }
