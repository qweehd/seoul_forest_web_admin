import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/ModelProvider.dart';

class CreatePublicNoticeModal extends StatefulWidget {
  const CreatePublicNoticeModal({super.key});

  @override
  State<CreatePublicNoticeModal> createState() =>
      _CreatePublicNoticeModalState();
}

class _CreatePublicNoticeModalState extends State<CreatePublicNoticeModal> {
  bool nationalScope = true;
  late List<Country> _countries;
  late List<City> _citiesInGermany;
  late List<City> _citiesInVietnam;

  final List<Country> _selectedCountries = [];
  final List<City> _selectedCities = [];
  final List<PublicNotice> _createdPublicNotices = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _sortNumController = TextEditingController();

  PublicNotice _createPublicNotice(String title, String content, int sortNum,
      bool nationalScope, City? city, Country? country) {
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
    _citiesInGermany =
        List<City>.generate(5, (index) => _createCity('Germany', index));
    _citiesInVietnam =
        List<City>.generate(4, (index) => _createCity('Vietnam', index));
    _countries = [
      _createCountry('Germany', _citiesInGermany, 0),
      _createCountry('Vietnam', _citiesInVietnam, 1)
    ];
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

  Country _createCountry(String name, List<City> cities, int index) {
    List<String> names = ['독일', '베트남'];
    List<String> codes = ['49', '84'];
    List<String> emojis = ['🇩🇪', '🇻🇳'];
    List<String> currencies = ['유로', '동'];
    List<String> currencyCodes = ['EUR', 'VND'];
    List<String> dialCodes = ['+49', '+84'];

    return Country(
        name: names[index],
        code: codes[index],
        flagEmoji: emojis[index],
        cities: cities,
        currency: currencies[index],
        currencyCode: currencyCodes[index],
        dialCode: dialCodes[index]);
  }

  City _createCity(String country, int index) {
    List<String> names = country == 'Germany'
        ? ['베를린', '뮌헨', '프랑크푸르트', '쾰른', '하노버']
        : ['하노이', '호치민', '다낭', '나트랑'];
    List<String> states = country == 'Germany'
        ? ['브란덴부르크', '바이에른', '헤센', '노르트라인-베스트팔렌', '하노버']
        : ['하노이', '호치민', '다낭', '나트랑'];

    return City(
        name: names[index],
        state: states[index],
        latitude: 20.12313,
        longitude: 93.2331,
        imageKey: '',
        hasMainCategories: [MainCategoryType.COMMUNITY]);
  }

  Widget _createChip(Country country) {
    return Chip(
        label: Text(country.name),
        onDeleted: () {
          setState(() {
            _countries.add(country);
            _selectedCountries.remove(country);
          });
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
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('완료', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _createBody() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('공지사항 범위'),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
        MaterialButton(
          minWidth: MediaQuery.of(context).size.width - 40,
          height: 50,
          color: Colors.blue,
          onPressed: () {
            /*publicNotice를 생성하고 확인하는 화면 표시 */
            if (nationalScope) {
              for (Country country in _selectedCountries) {
                _createdPublicNotices.add(_createPublicNotice(
                    _titleController.text,
                    _contentController.text,
                    int.parse(_sortNumController.text),
                    nationalScope,
                    null,
                    country));
                safePrint(_createdPublicNotices.toString());
              }
            } else {
              for (City city in _selectedCities) {
                _createdPublicNotices.add(_createPublicNotice(
                    _titleController.text,
                    _contentController.text,
                    int.parse(_sortNumController.text),
                    nationalScope,
                    city,
                    null));
                safePrint(_createdPublicNotices.length.toString());
              }
            }
          },
          child: const Text('입력'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: _createBody(),
    );
  }
}
