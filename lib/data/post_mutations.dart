
class PostMutations {
  static const String deletePost = '''
  mutation DeletePost(\$id: ID = "") {
    deletePost(input: {id: \$id}) {
      id
    }
  }
  ''';

  static const String updatePost = '''
     mutation UpdatePost(\$id: ID = "", \$currency: String = "", \$content: String = "", \$isNegotiable: Boolean = false, \$price: Int = 10, \$title: String = "") {
      updatePost(input: {id: \$id, content: \$content, currency: \$currency, isNegotiable: \$isNegotiable, price: \$price, title: \$title}) {
        id
      }
    }
  ''';
}