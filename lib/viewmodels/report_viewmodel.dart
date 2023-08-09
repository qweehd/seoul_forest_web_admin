import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import '../data/report_repository.dart';
import '../models/ModelProvider.dart';

class ReportViewModel extends ChangeNotifier {
  final ReportRepository _reportRepository;

  ReportViewModel({required ReportRepository reportRepository})
      : _reportRepository = reportRepository;

  List<Report> _reportItems = [];

  List<Report> get reportItems => _reportItems;

  bool reportLoading = false;

  Future<void> queryReportItems() async {
    reportLoading = true;
    Future.microtask(() => notifyListeners());
    final reportList = await _reportRepository.queryListItems();
    _reportItems = reportList.map((e) => e as Report).toList();
    reportLoading = false;
    Future.microtask(() => notifyListeners());
  }
}
