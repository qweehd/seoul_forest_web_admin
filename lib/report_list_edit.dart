import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/report_list.dart';

class ReportListEditPage extends StatefulWidget {
  final ReportItem reportitem;

  const ReportListEditPage({Key? key, required this.reportitem}) : super(key: key);

  @override
  _ReportListEditPageState createState() => _ReportListEditPageState();
}

class _ReportListEditPageState extends State<ReportListEditPage> {
  late TextEditingController _idController;
  late TextEditingController _createdAtController;
  late TextEditingController _postIDController;
  late TextEditingController _reasonController;
  late TextEditingController _reportedUserIDController;
  late TextEditingController _reporterIDController;
  late TextEditingController _typeController;
  late TextEditingController _updatedAtController;
  late TextEditingController _typenameController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: '${widget.reportitem.id}');
    _createdAtController = TextEditingController(text: '${widget.reportitem.createdAt}');
    _postIDController = TextEditingController(text: '${widget.reportitem.postID}');
    _reasonController = TextEditingController(text: widget.reportitem.reason);
    _reportedUserIDController = TextEditingController(text: widget.reportitem.reportedUserID);
    _reporterIDController = TextEditingController(text: widget.reportitem.reporterID);
    _typeController = TextEditingController(text: widget.reportitem.type);
    _updatedAtController = TextEditingController(text: '${widget.reportitem.updatedAt}');
    _typenameController = TextEditingController(text: widget.reportitem.typename);
  }

  @override
  void dispose() {
    _idController.dispose();
    _createdAtController.dispose();
    _postIDController.dispose();
    _reasonController.dispose();
    _reportedUserIDController.dispose();
    _reporterIDController.dispose();
    _typeController.dispose();
    _updatedAtController.dispose();
    _typenameController.dispose();
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
              buildTextField(_postIDController, 'Post ID'),
              buildTextField(_reasonController, 'Reason'),
              buildTextField(_reportedUserIDController, 'Reported User ID'),
              buildTextField(_reporterIDController, 'Reporter ID'),
              buildTextField(_typeController, 'Type'),
              buildTextField(_updatedAtController, 'Updated At'),
              buildTextField(_typenameController, 'typename'),
              ElevatedButton(
                onPressed: () {
                  // Implement the update logic here
                  print('Updated ID: ${_idController.text}');
                  print('Updated Created At: ${_createdAtController.text}');
                  print('Updated Post ID: ${_postIDController.text}');
                  print('Updated Reason: ${_reasonController.text}');
                  print('Updated Reported User ID: ${_reportedUserIDController.text}');
                  print('Updated Reporter ID: ${_reporterIDController.text}');
                  print('Updated Type: ${_typeController.text}');
                  print('Updated Updated At: ${_updatedAtController.text}');
                  print('Updated typename: ${_typenameController.text}');
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
