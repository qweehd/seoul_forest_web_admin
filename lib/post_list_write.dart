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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();
  final TextEditingController _mainCategoryIDController =
      TextEditingController();
  final TextEditingController _mainCategoryTypeController =
      TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _subCategoryIDController =
      TextEditingController();
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _typenameController = TextEditingController();
  final TextEditingController _imageKeysController = TextEditingController();

  bool? _isNegotiable; // Radio 위젯의 선택값을 저장

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
            buildTextFormField(_titleController, 'Title'),
            buildTextFormField(_contentController, 'Content'),
            buildTextFormField(_currencyController, 'Currency'),
            buildTextFormField(_mainCategoryIDController, 'Main Category ID'),
            buildTextFormField(
                _mainCategoryTypeController, 'Main Category Type'),
            buildTextFormField(_priceController, 'Price'),
            buildTextFormField(_statusController, 'Status'),
            buildTextFormField(_subCategoryIDController, 'Sub Category ID'),
            buildTextFormField(_userIDController, 'User ID'),
            buildTextFormField(_typenameController, '__typename'),
            buildTextFormField(
                _imageKeysController, 'Image Keys (comma-separated)'),
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
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate() &&
                    _isNegotiable != null) {
                  var postItem = Post(
                    title: _titleController.text,
                    content: _contentController.text,
                    currency: _currencyController.text,
                    mainCategoryType: MainCategoryType.MARKETPLACE,
                    price: int.parse(_priceController.text),
                    status: _statusController.text,
                    subCategory: SubCategory(
                      id: _subCategoryIDController.text,
                      name: '',
                      title: '',
                      mainCategoryType: MainCategoryType.COMMUNITY,
                      sortNum: 0,
                    ),
                    authorUser: User(
                        userName: '',
                        phone: '',
                        devicePlatform: DevicePlatform.ANDROID,
                        deviceToken: '',
                        isCompletelyRegistered: true),
                    imageKeys: _imageKeysController.text.split(','),
                    isNegotiable: _isNegotiable!,
                    createdAt: TemporalDateTime.now(),
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
