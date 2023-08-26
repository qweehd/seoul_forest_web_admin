import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:seoul_forest_web_admin/viewmodels/public_notice_viewmodel.dart';
import 'package:seoul_forest_web_admin/viewmodels/region_viewmodel.dart';

import '../models/ModelProvider.dart';

class CreatePublicNoticeModal extends StatefulWidget {
  const CreatePublicNoticeModal({super.key});

  @override
  State<CreatePublicNoticeModal> createState() =>
      _CreatePublicNoticeModalState();
}

class _CreatePublicNoticeModalState extends State<CreatePublicNoticeModal> {
  late RegionViewModel _regionViewModel;

  bool nationalScope = true;
  late List<Country> _countries;

  final List<Country> _selectedCountries = [];
  final List<City> _selectedCities = [];
  final List<PublicNotice> _createdPublicNotices = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _sortNumController = TextEditingController();

  PublicNotice _createPublicNotice(
      {required String title,
      required String content,
      required int sortNum,
      required bool nationalScope,
      required City city,
      required Country country}) {
    return PublicNotice(
      title: title,
      content: content,
      sortNum: sortNum,
      nationalScope: nationalScope,
      createdAt: TemporalDateTime.now(),
      city: city,
      country: country,
    );
  }

  @override
  void initState() {
    super.initState();
    _regionViewModel = Provider.of<RegionViewModel>(context, listen: false);
    _countries = _regionViewModel.countryItems;
  }

  void onSelectedCountry(Country country) {
    setState(() {
      if (_selectedCountries.contains(country)) {
        _selectedCountries.remove(country);
      } else {
        _selectedCountries.add(country);
      }
    });
  }

  PreferredSizeWidget _createAppBar() {
    return AppBar(
      title: const Text('공지사항 작성'),
      leading: IconButton(
        onPressed: () {
          context.go('/');
        },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _createBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('공지사항 범위'),
              const SizedBox(width: 10),
              CupertinoSwitch(
                  value: nationalScope,
                  onChanged: (value) {
                    setState(() {
                      nationalScope = value;
                    });
                  }),
              const SizedBox(width: 10),
              Text(nationalScope ? '나라별' : '도시별'),
            ],
          ),
          const Center(
            child: Text('공지할 나라', style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 20),
          _countries.isEmpty
              ? const SizedBox()
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _countries
                      .map((country) => GestureDetector(
                            onTap: () {
                              onSelectedCountry(country);
                            },
                            child: Container(
                                constraints: const BoxConstraints(
                                    minWidth: 80, minHeight: 80),
                                decoration: BoxDecoration(
                                    border: _selectedCountries.contains(country)
                                        ? Border.all(
                                            color: Colors.green, width: 5)
                                        : Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      country.flagEmoji,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      country.name,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ],
                                )),
                          ))
                      .toList(),
                ),
          const SizedBox(height: 20),
          if (!nationalScope)
            for (var country in _selectedCountries)
              Column(
                children: [
                  const SizedBox(height: 20),
                  Text('${country.name}의 도시',
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: country.cities!
                        .map((city) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_selectedCities.contains(city)) {
                                    _selectedCities.remove(city);
                                  } else {
                                    _selectedCities.add(city);
                                  }
                                });
                              },
                              child: Container(
                                  constraints: const BoxConstraints(
                                      minWidth: 80, minHeight: 80),
                                  decoration: BoxDecoration(
                                      border: _selectedCities.contains(city)
                                          ? Border.all(
                                              color: Colors.green, width: 5)
                                          : Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        city.name,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  )),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
          const SizedBox(height: 20),
          const Text('제목', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '제목을 입력하세요',
            ),
          ),
          const SizedBox(height: 20),
          const Text('내용', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          TextField(
            controller: _contentController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '내용을 입력하세요',
            ),
          ),
          const SizedBox(height: 20),
          const Text('순서', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          TextField(
            controller: _sortNumController,
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      child: CupertinoPicker(
                        itemExtent: 40,
                        onSelectedItemChanged: (int value) {
                          _sortNumController.text = value.toString();
                        },
                        children: List<Widget>.generate(
                          11,
                          (int index) {
                            return Center(
                              child: Text(
                                index.toString(),
                                style: const TextStyle(fontSize: 20),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '낮을 상위에 위치',
            ),
          ),
          const SizedBox(height: 20),
          createMaterialButton(context, nationalScope),
        ],
      ),
    );
  }

// MaterialButton을 생성하는 별도의 함수
  Widget createMaterialButton(BuildContext context, bool nationalScope) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width - 40,
      height: 50,
      color: Colors.blue,
      onPressed: () {
        generatePublicNotice(nationalScope);
      },
      child: const Text('입력'),
    );
  }

// 공지사항을 생성하는 함수 (국가 또는 도시에 따라)
  Future<void> generatePublicNotice(bool nationalScope) async {
    List<dynamic> selectedRegions =
        nationalScope ? _selectedCountries : _selectedCities;

    for (var region in selectedRegions) {
      _createdPublicNotices.add(_createPublicNotice(
          title: _titleController.text,
          content: _contentController.text,
          sortNum: int.parse(_sortNumController.text),
          nationalScope: nationalScope,
          city: nationalScope ? null : region,
          country: nationalScope ? region : null));
    }

    await createPublicNotices(_createdPublicNotices);
  }

// PublicNotice 객체를 생성하고 SnackBar를 출력하는 함수
  Future<void> createPublicNotices(List<PublicNotice> notices) async {
    for (PublicNotice notice in notices) {
      bool result =
          await Provider.of<PublicNoticeViewModel>(context, listen: false)
              .createPublicNotice(notice);
      String message = result ? '공지사항이 생성되었습니다.' : '공지사항 생성에 실패했습니다.';
      showSnackBar(context, message);
    }
  }

// SnackBar 출력을 위한 별도의 함수
  Future<void> showSnackBar(BuildContext context, String message) async {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

// UI 부분에서는 이렇게 사용

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: SingleChildScrollView(child: _createBody()),
    );
  }
}

class RequestResult {
  final bool result;
  final String message;

  RequestResult(this.result, this.message);
}
