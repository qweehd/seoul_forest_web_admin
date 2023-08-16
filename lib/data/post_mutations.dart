
class PostMutations {
  static const String deletePost = '''
  mutation DeletePost(\$id: ID = "") {
    deletePost(input: {id: \$id}) {
      id
    }
  }
  ''';
}