import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/user_list.dart'; // 필요한 Notice 클래스를 불러오기 위해 사용합니다.

class UserWritePage extends StatefulWidget {
  UserWritePage({Key? key}) : super(key: key);

  @override
  _UserWritePageState createState() => _UserWritePageState();
}

class _UserWritePageState extends State<UserWritePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _cityIDController = TextEditingController();
  final TextEditingController _createdAtController = TextEditingController();
  final TextEditingController _deviceTokenController = TextEditingController();
  final TextEditingController _imageKeyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _updatedAtController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _typenameController = TextEditingController();
  final TextEditingController _devicePlatformController = TextEditingController();

  bool? _isCompletelyRegistered;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('공지사항 작성하기'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
           buildTextFormField(_idController, 'id'),
            buildTextFormField(_cityIDController, 'cityID'),
            buildTextFormField(_createdAtController, 'createdAt'),
            buildTextFormField(_deviceTokenController, 'deviceToken'),
            buildTextFormField(_imageKeyController, 'imageKey'),
            buildTextFormField(_phoneController, 'phone'),
            buildTextFormField(_updatedAtController, 'updatedAt'),
            buildTextFormField(_userNameController, 'userName'),
            buildTextFormField(_typenameController, 'typename'),
            buildTextFormField(_devicePlatformController, 'devicePlatform'),
            SizedBox(height: 20),
            Text('isCompletelyRegistered:'),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('True'),
                    leading: Radio<bool>(
                      value: true,
                      groupValue: _isCompletelyRegistered,
                      onChanged: (value) {
                        setState(() {
                          _isCompletelyRegistered = value;
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
                      groupValue: _isCompletelyRegistered,
                      onChanged: (value) {
                        setState(() {
                          _isCompletelyRegistered = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var userItem = UserItem(
                    id: DateTime.now().millisecondsSinceEpoch,
                    cityID: int.parse(_cityIDController.text),
                    createdAt: DateTime.now(),
                    deviceToken: _deviceTokenController.text,
                    imageKey: _imageKeyController.text,
                    phone: _phoneController.text,
                    updatedAt: DateTime.now(),
                    userName: _userNameController.text,
                    typename: _typenameController.text,
                    devicePlatform: _devicePlatformController.text,
                    isCompletelyRegistered: _isCompletelyRegistered!,
                  );
                  Navigator.pop(context, userItem);
                }
              },
              child: Text('저장하기'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField(TextEditingController controller, String label, {bool isMultiline = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      maxLines: isMultiline ? null : 1,  // 다중 줄 입력을 위한 설정
      keyboardType: isMultiline ? TextInputType.multiline : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label을(를) 입력해주세요.';
        }
        return null;
      },
    );
  }
}
