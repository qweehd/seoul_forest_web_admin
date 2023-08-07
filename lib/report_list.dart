import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/report_list_edit.dart';
import 'package:seoul_forest_web_admin/report_list_write.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:seoul_forest_web_admin/viewmodels/report_viewmodel.dart';
import 'models/Report.dart';
import 'viewmodels/notice_viewmodel.dart';



class ReportItem {
  final int id;
  final DateTime createdAt;
  final int reportedPost;
  final int reportedComment;
  final int reportedReply;
  final String reason;
  final String reportedUser;
  final String reporter;
  final String type;
  final DateTime updatedAt;

  ReportItem({
    required this.id,
    required this.createdAt,
    required this.reportedPost,
    required this.reportedComment,
    required this.reportedReply,
    required this.reason,
    required this.reportedUser,
    required this.reporter,
    required this.type,
    required this.updatedAt,
  });
}

class ReportList extends StatefulWidget {
  const ReportList({
    Key? key,
  }) : super(key: key);

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  late Map<String, bool> checkedMap;
  late List<Report> reportList;

  @override
  void initState() {
    super.initState();
    checkedMap = {};
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportViewModel>(builder: (context, viewModel, child) {
      if (viewModel.reportItems.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }
      if (viewModel.reportItems != null) {
        reportList = viewModel.reportItems;
      }
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
                      MaterialPageRoute(builder: (context) => ReportWritePage()),
                    ).then((newReportItem) {
                      if (newReportItem != null) {
                        setState(() {
                          reportList.add(newReportItem); // 새로운 Notice를 목록에 추가
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
                DataColumn(label: Text('Created At')),
                DataColumn(label: Text('Reported Post ')),
                DataColumn(label: Text('Reported Comment')),
                DataColumn(label: Text('Reported Reply')),
                DataColumn(label: Text('Reason')),
                DataColumn(label: Text('Reported User')),
                DataColumn(label: Text('Reporter')),
                DataColumn(label: Text('Type')),
                DataColumn(label: Text('Updated At')),
                DataColumn(label: Text('type')),
              ],
              rows: reportList.map((Report reportitem) {
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
                    DataCell(buildDataCell(context, reportitem.id, reportitem)),
                    DataCell(buildDataCell(context, '${reportitem.createdAt}', reportitem)),
                    DataCell(buildDataCell(context, '${reportitem.reportedPost}', reportitem)),
                    DataCell(buildDataCell(context, '${reportitem.reportedComment}', reportitem)),
                    DataCell(buildDataCell(context, '${reportitem.reportedReply}', reportitem)),
                    DataCell(buildDataCell(context, '${reportitem.reason}', reportitem)),
                    DataCell(buildDataCell(context, '${reportitem.reportedUser}', reportitem)),
                    DataCell(buildDataCell(context, '${reportitem.reporter}', reportitem)),
                    DataCell(buildDataCell(context, '${reportitem.type}', reportitem)),
                    DataCell(buildDataCell(context, '${reportitem.updatedAt}', reportitem)),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
    );
  }

  void deleteSelected() {
    setState(() {
      reportList.removeWhere((reportitem) => checkedMap[reportitem.id] == true);
    });
  }

  Widget buildDataCell(BuildContext context, String data, Report reportitem) {
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
