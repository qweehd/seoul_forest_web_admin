import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/report_list.dart';
import 'package:seoul_forest_web_admin/user_list.dart'; // 필요한 Notice 클래스를 불러오기 위해 사용합니다.

class ReportWritePage extends StatefulWidget {
  ReportWritePage({Key? key}) : super(key: key);

  @override
  _ReportWritePageState createState() => _ReportWritePageState();
}

class _ReportWritePageState extends State<ReportWritePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _createdAtController = TextEditingController();
  final TextEditingController _postIDController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _reportedUserIDController = TextEditingController();
  final TextEditingController _reporterIDController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _updatedAtController = TextEditingController();
  final TextEditingController _typenameController = TextEditingController();

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
            buildTextFormField(_createdAtController, 'createdAt'),
            buildTextFormField(_postIDController, 'postID'),
            buildTextFormField(_reasonController, 'reason'),
            buildTextFormField(_reportedUserIDController, 'reportedUserID'),
            buildTextFormField(_reporterIDController, 'reporterID'),
            buildTextFormField(_typeController, 'type'),
            buildTextFormField(_updatedAtController, 'updatedAt'),
            buildTextFormField(_typenameController, 'typenamePlatform'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var reportItem = ReportItem(
                    id: DateTime.now().millisecondsSinceEpoch,
                    createdAt: DateTime.now(),
                    postID: int.parse(_postIDController.text),
                    reason: _reasonController.text,
                    reportedUserID: _reportedUserIDController.text,
                    reporterID: _reporterIDController.text,
                    type: _typeController.text,
                    updatedAt: DateTime.now(),
                    typename: _typenameController.text,
                  );
                  Navigator.pop(context, reportItem);
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
