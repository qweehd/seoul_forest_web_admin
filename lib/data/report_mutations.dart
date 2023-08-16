
class ReportMutations {
  static const String deleteReport = '''
  mutation DeleteReport(\$id: ID = "") {
    deleteReport(input: {id: \$id}) {
      id
    }
  }
  ''';
}