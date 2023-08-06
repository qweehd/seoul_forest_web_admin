import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/public_notice_edit.dart';
import 'package:seoul_forest_web_admin/public_notice_write.dart';

class NoticeItem {
  final int id;
  final String content;
  final DateTime createdAt;
  final int sortNum;
  final String title;
  final DateTime updateAt;

  NoticeItem({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.sortNum,
    required this.title,
    required this.updateAt,
  });
}

class PublicNoticeList extends StatefulWidget {
  final List<NoticeItem> noticeItems;

  const PublicNoticeList({Key? key, required this.noticeItems}) : super(key: key);

  @override
  _PublicNoticeListState createState() => _PublicNoticeListState();
}

class _PublicNoticeListState extends State<PublicNoticeList> {
  late Map<int, bool> checkedMap;
  late List<NoticeItem> notices;

  @override
  void initState() {
    super.initState();
    checkedMap = {for (var i = 0; i < 10; i++) i: false};
    notices = widget.noticeItems;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: Text('추가하기'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PublicNoticeWritePage()),
                    ).then((newNoticeItem) {
                      if (newNoticeItem != null) {
                        setState(() {
                          notices.add(newNoticeItem); // 새로운 Notice를 목록에 추가
                        });
                      }
                    });
                  },
                ),
                SizedBox(width: 10), // This gives some space between the buttons
                ElevatedButton(
                  child: Text('삭제하기'),
                  onPressed: deleteSelected,
                ),
              ],
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
              rows: notices.map((NoticeItem notice) {
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

  Widget buildDataCell(BuildContext context, String data, NoticeItem notice) {
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