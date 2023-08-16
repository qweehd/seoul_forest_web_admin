import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import '../data/public_notice_repository.dart';
import '../models/ModelProvider.dart';

class PublicNoticeViewModel extends ChangeNotifier {
  final PublicNoticeRepository _publicNoticeRepository;

  PublicNoticeViewModel({required PublicNoticeRepository publicNoticeRepository})
      : _publicNoticeRepository = publicNoticeRepository;

  List<PublicNotice> _publicNoticeItems = [];

  List<PublicNotice> get publicNoticeItems => _publicNoticeItems;

  bool publicNoticeLoading = false;

  Future<void> queryNoticeItems() async {
    publicNoticeLoading = true;
    Future.microtask(() => notifyListeners());
    final noticeList = await _publicNoticeRepository.queryListItems();
    _publicNoticeItems = noticeList.map((e) => e as PublicNotice).toList();
    _publicNoticeItems.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    publicNoticeLoading = false;
    Future.microtask(() => notifyListeners());
  }


}

