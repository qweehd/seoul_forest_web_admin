import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/public_notice.dart';

import 'models/PublicNotice.dart'; // 필요한 Notice 클래스를 불러오기 위해 사용합니다.

class PublicNoticeWritePage extends StatefulWidget {
  PublicNoticeWritePage({Key? key}) : super(key: key);

  @override
  _PublicNoticeWritePageState createState() => _PublicNoticeWritePageState();
}

class _PublicNoticeWritePageState extends State<PublicNoticeWritePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _sortNumController = TextEditingController();
  final TextEditingController _createdAtController = TextEditingController();
  final TextEditingController _updatedAtController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

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
            buildTextFormField(_titleController, 'title'),
            buildTextFormField(_contentController, 'content', isMultiline: true),
            buildTextFormField(_sortNumController, 'sortNum'),
            buildTextFormField(_createdAtController, 'createdAt'),
            buildTextFormField(_updatedAtController, 'updatedAt'),
            buildTextFormField(_idController, 'id'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var noticeItem = PublicNotice(
                    id: _idController.text,
                    title: _titleController.text,
                    content: _contentController.text,
                    sortNum: int.parse(_sortNumController.text),
                  );
                  Navigator.pop(context, noticeItem);
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
