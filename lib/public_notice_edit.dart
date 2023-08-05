import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/public_notice.dart';

class EditNoticePage extends StatefulWidget {
  final Notice notice;

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
  late TextEditingController _updateAtController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: '${widget.notice.id}');
    _titleController = TextEditingController(text: widget.notice.title);
    _contentController = TextEditingController(text: widget.notice.content);
    _createdAtController = TextEditingController(text: '${widget.notice.createdAt}');
    _sortNumController = TextEditingController(text: '${widget.notice.sortNum}');
    _updateAtController = TextEditingController(text: '${widget.notice.updateAt}');
  }

  @override
  void dispose() {
    _idController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    _createdAtController.dispose();
    _sortNumController.dispose();
    _updateAtController.dispose();
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
        child: Column(
          children: <Widget>[
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'ID',
              ),
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Content',
              ),
            ),
            TextField(
              controller: _createdAtController,
              decoration: InputDecoration(
                labelText: 'Created At',
              ),
            ),
            TextField(
              controller: _sortNumController,
              decoration: InputDecoration(
                labelText: 'Sort Number',
              ),
            ),
            TextField(
              controller: _updateAtController,
              decoration: InputDecoration(
                labelText: 'Updated At',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement the update logic here
                print('Updated ID: ${_idController.text}');
                print('Updated Title: ${_titleController.text}');
                print('Updated Content: ${_contentController.text}');
                print('Updated Created At: ${_createdAtController.text}');
                print('Updated Sort Number: ${_sortNumController.text}');
                print('Updated Updated At: ${_updateAtController.text}');
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Public Notice List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Public Notice List'),
        ),
        body: PublicNotice(),
      ),
    );
  }
}
