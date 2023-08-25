
class PublicNoticeMutations {
  static const String deletePublicNotice = '''
  mutation DeletePublicNotice(\$id: ID = "") {
    deletePublicNotice(input: {id: \$id}) {
      id
    }
  }
  ''';
  
  static const String createPublicNotice = '''
  mutation MyMutation(\$cityID: ID = "", \$content: String = "", \$countryID: ID = "", \$nationalScope: Boolean = false, \$sortNum: Int = 10, \$title: String = "") {
  createPublicNotice(input: {cityID: \$cityID, content: \$content, countryID: \$countryID, sortNum: \$sortNum, title: \$title, nationalScope: \$nationalScope}) {
    id
  }
}
''';

}