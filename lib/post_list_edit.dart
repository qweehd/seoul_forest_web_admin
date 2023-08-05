import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/post_list.dart';

class PostListEditPage extends StatefulWidget {
  final PostItem postitem;

  const PostListEditPage({Key? key, required this.postitem}) : super(key: key);

  @override
  _PostListEditPageState createState() => _PostListEditPageState();
}

class _PostListEditPageState extends State<PostListEditPage> {
  late TextEditingController _idController;
  late TextEditingController _contentController;
  late TextEditingController _createdAtController;
  late TextEditingController _currencyController;
  // You need to handle List<String> for imageKeys
  late TextEditingController _isNegotiableController;
  late TextEditingController _mainCategoryIDController;
  late TextEditingController _mainCategoryTypeController;
  late TextEditingController _priceController;
  late TextEditingController _statusController;
  late TextEditingController _subCategoryIDController;
  late TextEditingController _titleController;
  late TextEditingController _updatedAtController;
  late TextEditingController _userIDController;
  late TextEditingController _typenameController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: '${widget.postitem.id}');
    _contentController = TextEditingController(text: widget.postitem.content);
    _createdAtController = TextEditingController(text: '${widget.postitem.createdAt}');
    _currencyController = TextEditingController(text: widget.postitem.currency);
    _isNegotiableController = TextEditingController(text: '${widget.postitem.isNegotiable}');
    _mainCategoryIDController = TextEditingController(text: '${widget.postitem.mainCategoryID}');
    _mainCategoryTypeController = TextEditingController(text: widget.postitem.mainCategoryType);
    _priceController = TextEditingController(text: '${widget.postitem.price}');
    _statusController = TextEditingController(text: widget.postitem.status);
    _subCategoryIDController = TextEditingController(text: '${widget.postitem.subCategoryID}');
    _titleController = TextEditingController(text: widget.postitem.title);
    _updatedAtController = TextEditingController(text: '${widget.postitem.updatedAt}');
    _userIDController = TextEditingController(text: widget.postitem.userID);
    _typenameController = TextEditingController(text: widget.postitem.typename);
  }

  @override
  void dispose() {
    _idController.dispose();
    _contentController.dispose();
    _createdAtController.dispose();
    _currencyController.dispose();
    _isNegotiableController.dispose();
    _mainCategoryIDController.dispose();
    _mainCategoryTypeController.dispose();
    _priceController.dispose();
    _statusController.dispose();
    _subCategoryIDController.dispose();
    _titleController.dispose();
    _updatedAtController.dispose();
    _userIDController.dispose();
    _typenameController.dispose();
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
            buildTextField(_contentController, 'Content'),
            buildTextField(_createdAtController, 'Created At'),
            buildTextField(_currencyController, 'Currency'),
            // Handle imageKeys properly here
            buildTextField(_isNegotiableController, 'Is Negotiable'),
            buildTextField(_mainCategoryIDController, 'Main Category ID'),
            buildTextField(_mainCategoryTypeController, 'Main Category Type'),
            buildTextField(_priceController, 'Price'),
            buildTextField(_statusController, 'Status'),
            buildTextField(_subCategoryIDController, 'Sub Category ID'),
            buildTextField(_titleController, 'Title'),
            buildTextField(_updatedAtController, 'Updated At'),
            buildTextField(_userIDController, 'User ID'),
            buildTextField(_typenameController, '__typename'),
            ElevatedButton(
              onPressed: () {
                // Implement the update logic here
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
