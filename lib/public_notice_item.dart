
import 'package:seoul_forest_web_admin/public_notice.dart';

List<NoticeItem> getNoticeItems() {
  return [
    NoticeItem(
      id: 1,
      content: 'This is post 1',
      createdAt: DateTime.now(),
      sortNum: 1,
      title: 'Post 1',
      updateAt: DateTime.now(),
    ),
    NoticeItem(
      id: 2,
      content: 'This is post 2',
      createdAt: DateTime.now(),
      sortNum: 2,
      title: 'Post 2',
      updateAt: DateTime.now(),
    ),
    // 추가하고 싶은 다른 PostItem들을 생성하여 추가합니다.
  ];
}
