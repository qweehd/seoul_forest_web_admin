import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'models/ModelProvider.dart';

class PostListWritePage extends StatefulWidget {
  PostListWritePage({Key? key}) : super(key: key);

  @override
  _PostListWritePageState createState() => _PostListWritePageState();
}

class _PostListWritePageState extends State<PostListWritePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _createdAtController = TextEditingController();
  final TextEditingController _imageKeysController = TextEditingController();

  final TextEditingController _mainCategoryTypeController =
  TextEditingController();
  final TextEditingController _subCategoryIDController =
  TextEditingController();
  final TextEditingController _cityIDController = TextEditingController();

  final TextEditingController _countryIDController = TextEditingController();
  final TextEditingController _updatedAtController = TextEditingController();
  final TextEditingController _authorUserIDController = TextEditingController();

  bool? _isNegotiable; // Radio 위젯의 선택값을 저장
  bool? _nationalScope; // Radio 위젯의 선택값을 저장
  bool? _nationalCurrency; // Radio 위젯의 선택값을 저장

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Post'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            buildTextFormField(_idController, 'ID'),
            buildTextFormField(_titleController, 'Title'),
            buildTextFormField(_contentController, 'Content'),

            buildTextFormField(_priceController, 'Price'),
            SizedBox(height: 20),
            Text('Is Negotiable:'),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('True'),
                    leading: Radio<bool>(
                      value: true,
                      groupValue: _isNegotiable,
                      onChanged: (value) {
                        setState(() {
                          _isNegotiable = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('False'),
                    leading: Radio<bool>(
                      value: false,
                      groupValue: _isNegotiable,
                      onChanged: (value) {
                        setState(() {
                          _isNegotiable = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('National Currency:'),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('True'),
                    leading: Radio<bool>(
                      value: true,
                      groupValue: _nationalCurrency,
                      onChanged: (value) {
                        setState(() {
                          _nationalCurrency = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('False'),
                    leading: Radio<bool>(
                      value: false,
                      groupValue: _nationalCurrency,
                      onChanged: (value) {
                        setState(() {
                          _nationalCurrency = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('National Currency:'),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('True'),
                    leading: Radio<bool>(
                      value: true,
                      groupValue: _nationalScope,
                      onChanged: (value) {
                        setState(() {
                          _nationalScope = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('False'),
                    leading: Radio<bool>(
                      value: false,
                      groupValue: _nationalScope,
                      onChanged: (value) {
                        setState(() {
                          _nationalScope = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            buildTextFormField(_createdAtController, 'Created At'),
            buildTextFormField(_imageKeysController, 'Image Keys'),

            buildTextFormField(
                _mainCategoryTypeController, 'Main Category Type'),
            buildTextFormField(_subCategoryIDController, 'Sub Category ID'),
            buildTextFormField(_cityIDController, 'City ID'),

            buildTextFormField(_countryIDController, 'Country ID'),
            buildTextFormField(_updatedAtController, 'Update At'),
            buildTextFormField(_authorUserIDController, 'Author User ID'),

            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate() &&
                    _isNegotiable != null) {
                  var postItem = Post(
                    id: _idController.text,
                    title: _titleController.text,
                    content: _contentController.text,

                    price: int.parse(_priceController.text),
                    isNegotiable: _isNegotiable!,
                    nationalCurrency: _nationalCurrency!,
                    nationalScope: _nationalScope!,

                    createdAt: TemporalDateTime.now(),
                    imageKeys: _imageKeysController.text.split(','),

                    mainCategoryType: MainCategoryType.MARKETPLACE,
                    subCategory: SubCategory(
                      id: _subCategoryIDController.text,
                      name: '',
                      title: '',
                      mainCategoryType: MainCategoryType.COMMUNITY,
                      sortNum: 0,
                    ),
                    city: City(
                      id: _cityIDController.text,
                      name: '',
                      country: Country(
                        id: _countryIDController.text,
                        name: '', code: '', flagEmoji: '', currency: '', currencyCode: '', dialCode: '',
                      ),
                      state: '', latitude: 0, longitude
                          : 0, imageKey: '', hasMainCategories: [],
                    ),
                    country: Country(
                      id: _countryIDController.text,
                      name: '', code: '', flagEmoji: '', currency: '', currencyCode: '', dialCode: '',
                    ),
                    authorUser: User(
                        userName: '',
                        phone: '',
                        devicePlatform: DevicePlatform.ANDROID,
                        deviceToken: '',
                        isCompletelyRegistered: true),

                  );
                  Navigator.pop(context, postItem);
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
