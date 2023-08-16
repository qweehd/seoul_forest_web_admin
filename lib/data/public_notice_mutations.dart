
class PublicNoticeMutations {
  static const String deletePublicNotice = '''
  mutation DeletePublicNotice(\$id: ID = "") {
    deletePublicNotice(input: {id: \$id}) {
      id
    }
  }
  ''';
}