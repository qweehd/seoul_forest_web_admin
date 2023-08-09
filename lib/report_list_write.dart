import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/report_list.dart';
import 'models/ModelProvider.dart';

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
  final TextEditingController _reportedCommentController =
      TextEditingController();
  final TextEditingController _reportedReplyController =
      TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _reportedUserController = TextEditingController();
  final TextEditingController _reporterController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _updatedAtController = TextEditingController();

  bool? _isCompletelyRegistered;

  ReportReason stringToReportReason(String value) {
    switch (value) {
      case 'RUDE_OR_INSULTING_BEHAVIOR':
        return ReportReason.RUDE_OR_INSULTING_BEHAVIOR;
      case 'INAPPROPRIATE_CONTENT':
        return ReportReason.INAPPROPRIATE_CONTENT;
      case 'SCAM_OR_ADVERTISEMENT':
        return ReportReason.SCAM_OR_ADVERTISEMENT;
      case 'EXPOSURE_OF_SENSITIVE_PERSONAL_INFORMATION':
        return ReportReason.EXPOSURE_OF_SENSITIVE_PERSONAL_INFORMATION;
      case 'INDISCRIMINATE_REPETITION_OF_SAME_CONTENT':
        return ReportReason.INDISCRIMINATE_REPETITION_OF_SAME_CONTENT;
      case 'JUST_REPORT':
        return ReportReason.JUST_REPORT;
      default:
        throw ArgumentError('Unknown ReportReason: $value');
    }
  }

  ReportType stringToReportType(String value) {
    switch (value) {
      case 'POST_REPORT':
        return ReportType.POST_REPORT;
      case 'COMMENT_REPORT':
        return ReportType.COMMENT_REPORT;
      case 'REPLY_REPORT':
        return ReportType.REPLY_REPORT;
      default:
        throw ArgumentError('Unknown ReportType: $value');
    }
  }

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
                  var reportItem = Report(
                    reportedPost: Post(
                      id: _reportedPostController.text,
                      title: '',
                      content: '',
                      createdAt: TemporalDateTime.now(),
                      mainCategoryType: MainCategoryType.COMMUNITY,
                    ),
                    reportedComment: Comment(
                        id: _reportedCommentController.text, content: ''),
                    reportedReply: Reply(id: _reportedReplyController.text, content: ''),
                    reportedUser: User(
                      id: _reportedUserController.text, userName: '', phone: '', devicePlatform: DevicePlatform.ANDROID, deviceToken: '', isCompletelyRegistered: true,
                    ),
                    reporter: User(
                      id: _reporterController.text, userName: '', phone: '', devicePlatform: DevicePlatform.ANDROID, deviceToken: '', isCompletelyRegistered: true,
                    ),
                    reason: stringToReportReason(_reasonController.text),
                    type: stringToReportType(_typeController.text),
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

  Widget buildTextFormField(TextEditingController controller, String label,
      {bool isMultiline = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      maxLines: isMultiline ? null : 1,
      // 다중 줄 입력을 위한 설정
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
