// post_items.dart

import 'package:seoul_forest_web_admin/user_list.dart';

List<UserItem> getUserItems() {
  return [
    UserItem(
      id: 1,
      cityID: 101,
      createdAt: DateTime.now(),
      devicePlatform: 'Android',
      deviceToken: 'deviceToken1',
      imageKey: 'image1',
      isCompletelyRegistered: true,
      phone: '+821012345678',
      updatedAt: DateTime.now(),
      userName: 'User1',
      typename: 'typename1',
    ),
    UserItem(
      id: 2,
      cityID: 102,
      createdAt: DateTime.now(),
      devicePlatform: 'iOS',
      deviceToken: 'deviceToken2',
      imageKey: 'image2',
      isCompletelyRegistered: false,
      phone: '+821098765432',
      updatedAt: DateTime.now(),
      userName: 'User2',
      typename: 'typename2',
    ),
    // 추가하고 싶은 다른 UserItem들을 생성하여 추가합니다.
  ];
}
