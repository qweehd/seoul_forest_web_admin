import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/post_list.dart';

import 'models/ModelProvider.dart';

class PostListEditPage extends StatefulWidget {
  final Post postitem;

  const PostListEditPage({Key? key, required this.postitem}) : super(key: key);

  @override
  _PostListEditPageState createState() => _PostListEditPageState();
}

class _PostListEditPageState extends State<PostListEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _idController;
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  late TextEditingController _priceController;
  late TextEditingController _isNegotiableController;
  late TextEditingController _nationalScopeController;
  late TextEditingController _nationalCurrencyController;

  late TextEditingController _createdAtController;
  late TextEditingController _imageKeysController;


  late TextEditingController _mainCategoryTypeController;
  late TextEditingController _subCategoryIDController;
  late TextEditingController _cityIDController;

  late TextEditingController _countryIDController;
  late TextEditingController _updatedAtController;
  late TextEditingController _authorUserIDController;

  bool? _isNegotiable; // Radio 위젯의 선택값을 저장
  bool? _nationalScope; // Radio 위젯의 선택값을 저장
  bool? _nationalCurrency; // Radio 위젯의 선택값을 저장

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: '${widget.postitem.id}');
    _titleController = TextEditingController(text: widget.postitem.title);
    _contentController = TextEditingController(text: widget.postitem.content);

    _priceController = TextEditingController(text: '${widget.postitem.price}');
    _isNegotiableController = TextEditingController(
        text: widget.postitem.isNegotiable.toString());
    _nationalScopeController = TextEditingController(
        text: widget.postitem.nationalScope.toString());
    _nationalCurrencyController = TextEditingController(
        text: widget.postitem.nationalCurrency.toString());

    _createdAtController =
        TextEditingController(text: '${widget.postitem.createdAt}');
    _imageKeysController =
        TextEditingController(text: '${widget.postitem.imageKeys}');
    _mainCategoryTypeController = TextEditingController(
        text: widget.postitem.mainCategoryType.toString());
    _subCategoryIDController =
        TextEditingController(text: '${widget.postitem.subCategory?.id}');
    _cityIDController =
        TextEditingController(text: '${widget.postitem.city?.id}');

    _countryIDController =
        TextEditingController(text: '${widget.postitem.country?.id}');

    _updatedAtController =
        TextEditingController(text: '${widget.postitem.updatedAt}');
    _authorUserIDController =
        TextEditingController(text: widget.postitem.authorUser?.id);

  }

  @override
  void dispose() {
    _idController.dispose();
    _titleController.dispose();
    _contentController.dispose();

    _priceController.dispose();
    _isNegotiableController.dispose();
    _nationalScopeController.dispose();
    _nationalCurrencyController.dispose();
    _createdAtController.dispose();
    _imageKeysController.dispose();
    _mainCategoryTypeController.dispose();
    _subCategoryIDController.dispose();
    _cityIDController.dispose();

    _countryIDController.dispose();
    _updatedAtController.dispose();
    _authorUserIDController.dispose();


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            buildTextField(_idController, 'ID'),
            buildTextField(_titleController, 'Title'),
            buildTextField(_contentController, 'Content'),

            buildTextField(_priceController, 'Price'),
            buildTextField(_isNegotiableController, 'Is Negotiable'),
            buildTextField(_nationalScopeController, 'National Scope'),
            buildTextField(_nationalCurrencyController, 'National Currency'),

            buildTextField(_createdAtController, 'Created At'),
            buildTextField(_imageKeysController, 'Image Keys'),

            buildTextField(_mainCategoryTypeController, 'Main Category Type'),

            buildTextField(_subCategoryIDController, 'Sub Category ID'),
            buildTextField(_cityIDController, 'City ID'),
            buildTextField(_countryIDController, 'Country ID'),

            buildTextField(_updatedAtController, 'Updated At'),
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
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
