import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/user_list.dart';
import 'models/ModelProvider.dart';

class UserListEditPage extends StatefulWidget {
  final User useritem;

  const UserListEditPage({Key? key, required this.useritem}) : super(key: key);

  @override
  _UserListEditPageState createState() => _UserListEditPageState();
}

class _UserListEditPageState extends State<UserListEditPage> {
  late TextEditingController _idController;
  late TextEditingController _cityIDController;
  late TextEditingController _createdAtController;
  late TextEditingController _devicePlatformController;
  late TextEditingController _deviceTokenController;
  late TextEditingController _imageKeyController;
  late TextEditingController _isCompletelyRegisteredController;
  late TextEditingController _phoneController;
  late TextEditingController _updatedAtController;
  late TextEditingController _userNameController;
  late TextEditingController _typeController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: '${widget.useritem.id}');
    _cityIDController = TextEditingController(text: '${widget.useritem.city}');
    _createdAtController = TextEditingController(text: '${widget.useritem.createdAt}');
    _devicePlatformController = TextEditingController(text: '${widget.useritem.devicePlatform}');
    _deviceTokenController = TextEditingController(text: widget.useritem.deviceToken);
    _imageKeyController = TextEditingController(text: widget.useritem.imageKey);
    _isCompletelyRegisteredController = TextEditingController(text: '${widget.useritem.isCompletelyRegistered}');
    _phoneController = TextEditingController(text: widget.useritem.phone);
    _updatedAtController = TextEditingController(text: '${widget.useritem.updatedAt}');
    _userNameController = TextEditingController(text: widget.useritem.userName);
    _typeController = TextEditingController(text: 'User');
  }

  @override
  void dispose() {
    _idController.dispose();
    _cityIDController.dispose();
    _createdAtController.dispose();
    _devicePlatformController.dispose();
    _deviceTokenController.dispose();
    _imageKeyController.dispose();
    _isCompletelyRegisteredController.dispose();
    _phoneController.dispose();
    _updatedAtController.dispose();
    _userNameController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView( // Added SingleChildScrollView for better UI experience
          child: Column(
            children: <Widget>[
              buildTextField(_idController, 'ID'),
              buildTextField(_cityIDController, 'City ID'),
              buildTextField(_createdAtController, 'Created At'),
              buildTextField(_devicePlatformController, 'Device Platform'),
              buildTextField(_deviceTokenController, 'Device Token'),
              buildTextField(_imageKeyController, 'Image Key'),
              buildTextField(_isCompletelyRegisteredController, 'Is Completely Registered'),
              buildTextField(_phoneController, 'Phone'),
              buildTextField(_updatedAtController, 'Updated At'),
              buildTextField(_userNameController, 'User Name'),
              buildTextField(_typeController, 'typename'),
              ElevatedButton(
                onPressed: () {
                  // Implement the update logic here
                  print('Updated ID: ${_idController.text}');
                  print('Updated City ID: ${_cityIDController.text}');
                  print('Updated Created At: ${_createdAtController.text}');
                  print('Updated Device Platform: ${_devicePlatformController.text}');
                  print('Updated Device Token: ${_deviceTokenController.text}');
                  print('Updated Image Key: ${_imageKeyController.text}');
                  print('Updated Is Completely Registered: ${_isCompletelyRegisteredController.text}');
                  print('Updated Phone: ${_phoneController.text}');
                  print('Updated Updated At: ${_updatedAtController.text}');
                  print('Updated User Name: ${_userNameController.text}');
                  print('Updated __typename: ${_typeController.text}');
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}
