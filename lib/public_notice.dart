import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/public_notice_edit.dart';

class Notice {
  final int id;
  final String content;
  final DateTime createdAt;
  final int sortNum;
  final String title;
  final DateTime updateAt;

  Notice({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.sortNum,
    required this.title,
    required this.updateAt,
  });
}

class PublicNoticeScreen extends StatefulWidget {
  const PublicNoticeScreen({Key? key}) : super(key: key);

  @override
  _PublicNoticeScreenState createState() => _PublicNoticeScreenState();
}

class _PublicNoticeScreenState extends State<PublicNoticeScreen> {
  late Map<int, bool> checkedMap;
  late List<Notice> notices;

  @override
  void initState() {
    super.initState();
    checkedMap = {for (var i = 0; i < 10; i++) i: false};
    notices = [
      Notice(
        id: 1,
        content: 'This is a test notice',
        createdAt: DateTime.now(),
        sortNum: 1,
        title: 'Test Notice',
        updateAt: DateTime.now(),
      ),
      // More notices...
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              child: Text('삭제하기'),
              onPressed: deleteSelected,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(label: Text('Select')),
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Title')),
                DataColumn(label: Text('Content')),
                DataColumn(label: Text('Created At')),
                DataColumn(label: Text('Sort Num')),
                DataColumn(label: Text('Updated At')),
              ],
              rows: notices.map((Notice notice) {
                return DataRow(
                  cells: <DataCell>[
                    DataCell(Checkbox(
                      value: checkedMap[notice.id],
                      onChanged: (value) {
                        setState(() {
                          checkedMap[notice.id] = value!;
                        });
                      },
                    )),
                    DataCell(buildDataCell(context, '${notice.id}', notice)),
                    DataCell(buildDataCell(context, notice.title, notice)),
                    DataCell(buildDataCell(context, notice.content, notice)),
                    DataCell(buildDataCell(context, '${notice.createdAt}', notice)),
                    DataCell(buildDataCell(context, '${notice.sortNum}', notice)),
                    DataCell(buildDataCell(context, '${notice.updateAt}', notice)),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
  void deleteSelected() {
    setState(() {
      notices.removeWhere((notice) => checkedMap[notice.id] == true);
    });
  }

  Widget buildDataCell(BuildContext context, String data, Notice notice) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditNoticePage(notice: notice)),
        );
      },
      child: Text(data),
    );
  }
}
