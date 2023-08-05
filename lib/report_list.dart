import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/report_list_edit.dart';
import 'package:seoul_forest_web_admin/user_list_edit.dart'; // 이 페이지를 작성해야 합니다.

class ReportItem {
  final int id;
  final DateTime createdAt;
  final int postID;
  final String reason;
  final String reportedUserID;
  final String reporterID;
  final String type;
  final DateTime updatedAt;
  final String typename;

  ReportItem({
    required this.id,
    required this.createdAt,
    required this.postID,
    required this.reason,
    required this.reportedUserID,
    required this.reporterID,
    required this.type,
    required this.updatedAt,
    required this.typename,
  });
}

class ReportList extends StatefulWidget {
  final List<ReportItem> reportItems;

  const ReportList({Key? key, required this.reportItems}) : super(key: key);

  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  late Map<int, bool> checkedMap;
  late List<ReportItem> reportItems;

  @override
  void initState() {
    super.initState();
    checkedMap = {for (var i = 0; i < 10; i++) i: false};
    reportItems = widget.reportItems;
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
                DataColumn(label: Text('Created At')),
                DataColumn(label: Text('Post ID')),
                DataColumn(label: Text('Reason')),
                DataColumn(label: Text('Reported User ID')),
                DataColumn(label: Text('Reporter ID')),
                DataColumn(label: Text('Type')),
                DataColumn(label: Text('Updated At')),
                DataColumn(label: Text('typename')),
              ],
              rows: reportItems.map((ReportItem reportitem) {
                return DataRow(
                  cells: <DataCell>[
                    DataCell(Checkbox(
                      value: checkedMap[reportitem.id],
                      onChanged: (value) {
                        setState(() {
                          checkedMap[reportitem.id] = value!;
                        });
                      },
                    )),
                    DataCell(buildDataCell(context, '${reportitem.id}', reportitem)),
                    DataCell(buildDataCell(context, '${reportitem.createdAt}', reportitem)),
                    DataCell(buildDataCell(context, '${reportitem.postID}', reportitem)),
                    DataCell(buildDataCell(context, reportitem.reason, reportitem)),
                    DataCell(buildDataCell(context, reportitem.reportedUserID, reportitem)),
                    DataCell(buildDataCell(context, reportitem.reporterID, reportitem)),
                    DataCell(buildDataCell(context, reportitem.type, reportitem)),
                    DataCell(buildDataCell(context, '${reportitem.updatedAt}', reportitem)),
                    DataCell(buildDataCell(context, reportitem.typename, reportitem)),
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
      reportItems.removeWhere((reportitem) => checkedMap[reportitem.id] == true);
    });
  }

  Widget buildDataCell(BuildContext context, String data, ReportItem reportitem) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReportListEditPage(reportitem: reportitem)), // 이 페이지를 작성해야 합니다.
        );
      },
      child: Text(data),
    );
  }
}
