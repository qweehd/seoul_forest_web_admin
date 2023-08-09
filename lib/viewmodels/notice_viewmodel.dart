import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import '../data/notice_repository.dart';
import '../models/ModelProvider.dart';

class NoticeViewModel extends ChangeNotifier {
  final NoticeRepository _noticeRepository;

  NoticeViewModel({required NoticeRepository noticeRepository})
      : _noticeRepository = noticeRepository;

  List<PublicNotice> _noticeItems = [];

  List<PublicNotice> get noticeItems => _noticeItems;

  bool noticeLoading = false;

  Future<void> queryNoticeItems() async {
    noticeLoading = true;
    Future.microtask(() => notifyListeners());
    final noticeList = await _noticeRepository.queryListItems();
    _noticeItems = noticeList.map((e) => e as PublicNotice).toList();
    noticeLoading = false;
    Future.microtask(() => notifyListeners());
  }
}
