import 'package:flutter/material.dart';

import 'models/Report.dart';

class ReportListEditPage extends StatefulWidget {
  final Report reportitem;

  const ReportListEditPage({Key? key, required this.reportitem})
      : super(key: key);

  @override
  _ReportListEditPageState createState() => _ReportListEditPageState();
}

class _ReportListEditPageState extends State<ReportListEditPage> {
  late TextEditingController _idController;
  late TextEditingController _createdAtController;
  late TextEditingController _reportedPostController;
  late TextEditingController _reportedCommentController;
  late TextEditingController _reportedReplyController;
  late TextEditingController _reasonController;
  late TextEditingController _reportedUserController;
  late TextEditingController _reporterController;
  late TextEditingController _typeController;
  late TextEditingController _updatedAtController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: '${widget.reportitem.id}');
    _createdAtController =
        TextEditingController(text: '${widget.reportitem.createdAt}');
    _reportedPostController =
        TextEditingController(text: '${widget.reportitem.reportedPost}');
    _reportedCommentController =
        TextEditingController(text: '${widget.reportitem.reportedComment}');
    _reportedReplyController =
        TextEditingController(text: '${widget.reportitem.reportedReply}');
    _reportedUserController =
        TextEditingController(text: '${widget.reportitem.reportedUser}');
    _reporterController =
        TextEditingController(text: '${widget.reportitem.reporter}');
    _reasonController =
        TextEditingController(text: '${widget.reportitem.reason}');
    _typeController =
        TextEditingController(text: '${widget.reportitem.type}');
    _updatedAtController =
        TextEditingController(text: '${widget.reportitem.updatedAt}');
  }

  @override
  void dispose() {
    _idController.dispose();
    _createdAtController.dispose();
    _reasonController.dispose();
    _typeController.dispose();
    _updatedAtController.dispose();
    _reportedCommentController.dispose();
    _reportedPostController.dispose();
    _reportedReplyController.dispose();
    _reportedUserController.dispose();
    _reporterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Report Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildTextField(_idController, 'ID'),
              buildTextField(_createdAtController, 'Created At'),
              buildTextField(_reportedPostController, 'Reported Post'),
              buildTextField(_reportedCommentController, 'Reported Comment'),
              buildTextField(_reportedReplyController, 'Reported Reply'),
              buildTextField(_reasonController, 'Reason'),
              buildTextField(_reportedUserController, 'Reported User'),
              buildTextField(_reporterController, 'Reporter'),
              buildTextField(_typeController, 'Type'),
              buildTextField(_updatedAtController, 'Updated At'),
              buildTextField(_typeController, 'type'),
              ElevatedButton(
                onPressed: () {
                  // Implement the update logic here
                  print('Updated ID: ${_idController.text}');
                  print('Updated Created At: ${_createdAtController.text}');
                  print(
                      'Updated Reported Post ID: ${_reportedPostController.text}');
                  print(
                      'Updated Reported Comment ID: ${_reportedCommentController.text}');
                  print(
                      'Updated Reported Reply ID: ${_reportedReplyController.text}');
                  print('Updated Reason: ${_reasonController.text}');
                  print(
                      'Updated Reported User ID: ${_reportedUserController.text}');
                  print('Updated Reporter ID: ${_reporterController.text}');
                  print('Updated Type: ${_typeController.text}');
                  print('Updated Updated At: ${_updatedAtController.text}');
                  print('Updated typename: ${_typeController.text}');
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
