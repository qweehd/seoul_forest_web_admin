import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import '../data/user_repository.dart';
import '../models/ModelProvider.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  UserViewModel({required UserRepository userRepository})
      : _userRepository = userRepository;

  List<User> _userItems = [];

  List<User> get userItems => _userItems;

  bool userLoading = false;

  Future<void> queryUserItems() async {
    userLoading = true;
    Future.microtask(() => notifyListeners());
    final userList = await _userRepository.queryListItems();
    _userItems = userList.map((e) => e as User).toList();
    _userItems.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    userLoading = false;
    Future.microtask(() => notifyListeners());
  }
}
