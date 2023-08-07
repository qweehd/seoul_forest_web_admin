import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/public_notice.dart';
import 'models/ModelProvider.dart';

class EditNoticePage extends StatefulWidget {
  final PublicNotice notice;

  const EditNoticePage({Key? key, required this.notice}) : super(key: key);

  @override
  _EditNoticePageState createState() => _EditNoticePageState();
}

class _EditNoticePageState extends State<EditNoticePage> {
  late TextEditingController _idController;
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _createdAtController;
  late TextEditingController _sortNumController;
  late TextEditingController _updatedAtController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: '${widget.notice.id}');
    _titleController = TextEditingController(text: widget.notice.title);
    _contentController = TextEditingController(text: widget.notice.content);
    _createdAtController = TextEditingController(text: '${widget.notice.createdAt}');
    _sortNumController = TextEditingController(text: '${widget.notice.sortNum}');
    _updatedAtController = TextEditingController(text: '${widget.notice.updatedAt}');
  }

  @override
  void dispose() {
    _idController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    _createdAtController.dispose();
    _sortNumController.dispose();
    _updatedAtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Notice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
        children: <Widget>[
          buildTextField(_idController, 'ID'),
          buildTextField(_titleController, 'Title'),
          buildTextField(_contentController, 'Content'),
          buildTextField(_createdAtController, 'CreatedAt'),
          buildTextField(_sortNumController, 'SortNum'),
          buildTextField(_updatedAtController, 'UpdateAt'),
         ElevatedButton(onPressed: (){

         },
             child: Text('수정하기')
         )
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