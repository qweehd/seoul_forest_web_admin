import 'package:flutter/cupertino.dart';
import 'package:seoul_forest_web_admin/data/region_repository.dart';

import '../models/ModelProvider.dart';

class RegionViewModel extends ChangeNotifier {
  final RegionRepository _regionRepository;

  RegionViewModel({required RegionRepository regionRepository})
      : _regionRepository = regionRepository;

  List<Country> _countryItems = [];

  List<Country> get countryItems => _countryItems;

  bool countryLoading = false;

  Future<void> queryCountryItems() async {
    countryLoading = true;
    Future.microtask(() => notifyListeners());
    final countryList = await _regionRepository.fetchAllCountries();
    _countryItems = countryList;
    countryLoading = false;
    Future.microtask(() => notifyListeners());
  }
}
