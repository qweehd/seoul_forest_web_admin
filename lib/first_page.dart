import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seoul_forest_web_admin/viewmodels/notice_viewmodel.dart';
import 'package:seoul_forest_web_admin/viewmodels/report_viewmodel.dart';
import 'package:seoul_forest_web_admin/viewmodels/user_viewmodel.dart';
import 'models/ModelProvider.dart';
import 'viewmodels/post_viewmodel.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late Map<String, bool> checkedMap;
  late List<Post> postList;
  late List<PublicNotice> noticeList;
  late List<User> userList;
  late List<Report> reportList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<NoticeViewModel>(builder: (context, viewModel, child) {
          if (viewModel.noticeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          noticeList = viewModel.noticeItems;
          List<PublicNotice> recentNoticeList = noticeList.take(5).toList();
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 5,
              columns: const <DataColumn>[
                DataColumn(label: Text('Title')),
                DataColumn(label: Text('Content')),
                DataColumn(label: Text('Created At')),
                DataColumn(label: Text('Sort Num')),
              ],
              rows: recentNoticeList.map((PublicNotice notice) {
                return DataRow(
                  cells: <DataCell>[
                    DataCell(
                        buildNoticeDataCell(context, notice.title, notice)),
                    DataCell(
                        buildNoticeDataCell(context, notice.content, notice)),
                    DataCell(buildNoticeDataCell(
                        context, '${notice.createdAt}', notice)),
                    DataCell(buildNoticeDataCell(
                        context, '${notice.sortNum}', notice)),
                  ],
                );
              }).toList(),
            ),
          );
        }),
          Consumer<PostViewModel>(builder: (context, viewModel, child) {
            if (viewModel.postLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            postList = viewModel.postItems;
            postList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            List<Post> recentPostList = postList.take(5).toList();
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 5,
                columns: const <DataColumn>[
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Content')),
                  DataColumn(label: Text('Created At')),
                  DataColumn(label: Text('Main Category Type')),
                  DataColumn(label: Text('Sub Category ID')),
                ],
                rows: recentPostList.map((Post post) {
                  return DataRow(
                    cells: <DataCell>[
                      /* Title Field*/
                      DataCell(buildDataCell(context, post.title, post)),
                      /* Content Field*/
                      DataCell(buildDataCell(context, post.content, post)),
                      /* Created At Field*/
                      DataCell(buildDataCell(
                          context, post.createdAt.toString(), post)),
                      /* MainCategoryType Field*/
                      DataCell(buildDataCell(
                        context,
                        getFormattedMainCategory(post.mainCategoryType),
                        post,
                      )),
                      /* SubCategoryID Field*/
                      DataCell(buildDataCell(
                          context, getFormattedSubCategory(post.subCategory?.id), post)),
                    ],
                  );
                }).toList(),
              ),
            );
          }),

          Consumer<UserViewModel>(builder: (context, viewModel, child) {
            if (viewModel.userLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            userList = viewModel.userItems;
            List<User> recentUserList = userList.take(5).toList();
            return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 5,
                      columns: const <DataColumn>[
                        DataColumn(label: Text('User Name')),
                        DataColumn(label: Text('Phone')),
                        DataColumn(label: Text('Created At')),
                        DataColumn(label: Text('Device Platform')),

                      ],
                      rows: recentUserList.map((User user) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(buildUserDataCell(
                              context, user.userName, user)),
                            DataCell(
                                buildUserDataCell(context, user.phone, user)),
                            DataCell(buildUserDataCell(
                                context, '${user.createdAt}', user)),
                            DataCell(buildUserDataCell(
                                context, '${user.devicePlatform}', user)),
                          ],
                        );
                      }).toList(),
                    ),
                  );
          }
          ),

          Consumer<ReportViewModel>(builder: (context, viewModel, child) {
            if (viewModel.reportLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            reportList = viewModel.reportItems;
            List<Report> recentReportList = reportList.take(5).toList();
            return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 5,
                      columns: const <DataColumn>[
                        DataColumn(label: Text('Type')),
                        DataColumn(label: Text('Reason')),
                        DataColumn(label: Text('Created At')),
                        DataColumn(label: Text('Reported User')),
                        DataColumn(label: Text('Reporter')),

                      ],
                      rows: recentReportList.map((Report reportitem) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(buildReportDataCell(
                              context, '${reportitem.type}', reportitem)),
                            DataCell(buildReportDataCell(
                                context, '${reportitem.reason}', reportitem)),
                            DataCell(buildReportDataCell(context,
                                reportitem.createdAt.toString(), reportitem)),
                            DataCell(buildReportDataCell(
                                context, '${reportitem.reportedUser}', reportitem)),
                            DataCell(buildReportDataCell(
                                context, '${reportitem.reporter}', reportitem)),

                          ],
                        );
                      }).toList(),
                    ),
                  );

          }),
        ],
      ),
    );
  }

  String getFormattedMainCategory(MainCategoryType categoryType) {
    if (categoryType == MainCategoryType.MARKETPLACE) {
      return '플리마켓';
    } else if (categoryType == MainCategoryType.COMMUNITY) {
      return '커뮤니티';
    }
    // 추가적인 조건이 있다면 여기에 계속해서 추가 가능
    return categoryType.toString();
  }

  String getFormattedSubCategory(String? categoryId) {
    if (categoryId == 'cbdbbdbf-b04e-4016-b43f-3b1c3f85b9fc') {
      return '중고거래';
    } else if (categoryId == 'bbed40cb-980b-4393-8478-d0a06184df03') {
      return '구인구직';
    } else if (categoryId == '9f73dccb-d96a-4b2f-8518-e32a918f651e') {
      return '고민상담';
    } else if (categoryId == '408e510e-c074-4817-aa27-7c6707b2ff86') {
      return '교환';
    } else if (categoryId == '7ac2d33c-6d53-4700-8fe7-0110f771be92') {
      return '방구함';
    } else if (categoryId == '60591395-f641-4a5c-b683-8a4d2c9ea71b') {
      return '자유토론';
    } else if (categoryId == '01eb6bf2-613b-48d6-bb2a-8278c4ebdeca') {
      return '방있음';
    } else if (categoryId == '8ae59ae7-d618-4f2a-93c2-972a1a83100b') {
      return '취미생활';
    } else if (categoryId == '9a81daa2-ae4d-4565-bf4d-36defbfbfb10') {
      return '일상';
    } else if (categoryId == 'aa948ba1-2faf-41d7-87fe-5693a40e0157') {
      return '뉴스소식';
    } else if (categoryId == 'b8c3b531-ad7c-4c92-b025-4fd69bcd0690') {
      return '생활문답';
    } else if (categoryId == '34ee3453-a31b-4ff1-8841-92e15bcffb41') {
      return '정보공유';
    }
    return categoryId.toString();
  }

  Widget buildDataCell(BuildContext context, String data, Post postitem) {
    return SizedBox(
      width: 220,
      child: Text(data),
    );
  }

Widget buildNoticeDataCell(BuildContext context, String data, PublicNotice noticeitem) {
  return SizedBox(
    width: 220,
    child: Text(data),
  );
}
  Widget buildUserDataCell(BuildContext context, String data, User useritem) {
    return SizedBox(
      width: 220,
      child: Text(data),
    );
  }
  Widget buildReportDataCell(BuildContext context, String data, Report reportitem) {
    return SizedBox(
      width: 220,
      child: Text(data),
    );
  }
}
