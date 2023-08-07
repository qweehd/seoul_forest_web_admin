import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/report_list.dart';

class ReportWritePage extends StatefulWidget {
  ReportWritePage({Key? key}) : super(key: key);

  @override
  _ReportWritePageState createState() => _ReportWritePageState();
}

class _ReportWritePageState extends State<ReportWritePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _createdAtController = TextEditingController();
  final TextEditingController _reportedPostController = TextEditingController();
final TextEditingController _reportedCommentController = TextEditingController();
final TextEditingController _reportedReplyController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _reportedUserController = TextEditingController();
  final TextEditingController _reporterController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _updatedAtController = TextEditingController();

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
            buildTextFormField(_reportedPostController, 'reportedPost'),
            buildTextFormField(_reportedCommentController, 'reportedComment'),
            buildTextFormField(_reportedReplyController, 'reportedReply'),
            buildTextFormField(_reasonController, 'reason'),
            buildTextFormField(_reportedUserController, 'reportedUser'),
            buildTextFormField(_reporterController, 'reporter'),
            buildTextFormField(_typeController, 'type'),
            buildTextFormField(_updatedAtController, 'updatedAt'),
            buildTextFormField(_typeController, 'typePlatform'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var reportItem = ReportItem(
                    id: DateTime.now().millisecondsSinceEpoch,
                    createdAt: DateTime.now(),
                    reportedPost: int.parse(_reportedPostController.text),
                    reportedComment: int.parse(_reportedCommentController.text),
                    reportedReply: int.parse(_reportedReplyController.text),
                    reason: _reasonController.text,
                    reportedUser: _reportedUserController.text,
                    reporter: _reporterController.text,
                    type: _typeController.text,
                    updatedAt: DateTime.now(),
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
