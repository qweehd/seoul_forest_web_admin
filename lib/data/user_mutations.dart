
class UserMutations {
  static const String deleteUser = '''
  mutation DeleteUser(\$id: ID = "") {
    deleteUser(input: {id: \$id}) {
      id
    }
  }
  ''';
}