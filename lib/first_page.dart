import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:seoul_forest_web_admin/public_notice/create_pn_modal_component.dart';
import 'package:seoul_forest_web_admin/viewmodels/public_notice_viewmodel.dart';
import 'package:seoul_forest_web_admin/viewmodels/report_viewmodel.dart';
import 'package:seoul_forest_web_admin/viewmodels/user_viewmodel.dart';
import 'models/ModelProvider.dart';
import 'viewmodels/post_viewmodel.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({
    Key? key,
  }) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late List<Post> postList;
  late List<PublicNotice> noticeList;
  late List<User> userList;
  late List<Report> reportList;

  String formatTemporalDateToMonthAndDay(String temporalDate) {
    List<String> parts = temporalDate.split("-");
    return "${parts[1]}/${parts[2].substring(0, 2)}"; // MM.dd 형식으로 반환
  }

  @override
  void initState() {
    super.initState();
  }

  void showCreatePublicNoticeModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8, // 너비 조정
            height: MediaQuery.of(context).size.height * 0.6, // 높이 조정
            child: const CreatePublicNoticeModal(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Container(
          color: Colors.blue[100],
          child: Row(
            children: [
              MaterialButton(
                minWidth: 200,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.all(40),
                onPressed: () {
                  // showCreatePublicNoticeModal();
                  context.go('/public_notice/create');
                },
                child: const Column(
                  children: [
                    Icon(
                      CupertinoIcons.wand_rays,
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '공지사항 작성',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              MaterialButton(
                minWidth: 200,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.all(40),
                onPressed: () {},
                child: const Column(
                  children: [
                    Icon(
                      CupertinoIcons.pencil_outline,
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '게시글 작성',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 10), // Add left padding
          child: Text('공지사항', style: TextStyle(fontSize: 20)),
        ),
        Consumer<PublicNoticeViewModel>(builder: (context, viewModel, child) {
          if (viewModel.publicNoticeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          noticeList = viewModel.publicNoticeItems;
          List<PublicNotice> recentNoticeList = noticeList.take(5).toList();
          return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Text('총 공지사항 수: ${noticeList.length}'),
                    ),
                    DataTable(
                      columnSpacing: 5,
                      columns: const <DataColumn>[
                        DataColumn(label: Text('제목')),
                        DataColumn(label: Text('내용')),
                        DataColumn(label: Text('작성시간')),
                        DataColumn(label: Text('정렬 우선순위')),
                      ],
                      rows: recentNoticeList.map((PublicNotice notice) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(buildNoticeDataCell(
                                context, notice.title, notice)),
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 300, // 최대 너비를 100픽셀로 제한
                                ),
                                child: buildNoticeDataCell(
                                    context, notice.content, notice),
                              ),
                            ),
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 80, // 최대 너비를 100픽셀로 제한
                                ),
                                child: buildNoticeDataCell(
                                    context,
                                    formatTemporalDateToMonthAndDay(
                                        notice.createdAt.toString()),
                                    notice),
                              ),
                            ),
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 80, // 최대 너비를 100픽셀로 제한
                                ),
                                child: buildNoticeDataCell(
                                    context, '${notice.sortNum}', notice),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ]));
        }),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 10), // Add left padding
          child: Text('게시물 현황', style: TextStyle(fontSize: 20)),
        ),
        Consumer<PostViewModel>(builder: (context, viewModel, child) {
          if (viewModel.postLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          postList = viewModel.postItems;
          List<Post> recentPostList = postList.take(5).toList();
          return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Text('총 게시물수: ${postList.length}'),
                    ),
                    DataTable(
                      columnSpacing: 5,
                      columns: const <DataColumn>[
                        DataColumn(label: Text('제목')),
                        DataColumn(label: Text('내용')),
                        DataColumn(label: Text('작성시간')),
                        DataColumn(label: Text('메인카테고리')),
                        DataColumn(label: Text('서브카테고리')),
                      ],
                      rows: recentPostList.map((Post post) {
                        return DataRow(
                          cells: <DataCell>[
                            /* Title Field*/
                            DataCell(
                                buildDataCell(context, post.title, post)),
                            /* Content Field*/
                            DataCell(
                                buildDataCell(context, post.content, post)),
                            /* Created At Field*/
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 80, // 최대 너비를 100픽셀로 제한
                                ),
                                child: buildDataCell(
                                    context,
                                    formatTemporalDateToMonthAndDay(
                                        post.createdAt.toString()),
                                    post),
                              ),
                            ),
                            /* MainCategoryType Field*/
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 90, // 최대 너비를 100픽셀로 제한
                                ),
                                child: buildDataCell(
                                    context,
                                    getFormattedMainCategory(
                                        post.mainCategoryType),
                                    post),
                              ),
                            ),
                            /* SubCategoryID Field*/
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 90, // 최대 너비를 100픽셀로 제한
                                ),
                                child: buildDataCell(
                                    context,
                                    getFormattedSubCategory(
                                        post.subCategory?.id),
                                    post),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ]));
        }),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 10), // Add left padding
          child: Text('유저목록', style: TextStyle(fontSize: 20)),
        ),
        Consumer<UserViewModel>(builder: (context, viewModel, child) {
          if (viewModel.userLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          userList = viewModel.userItems;
          List<User> recentUserList = userList.take(5).toList();
          return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Text('총 유저수: ${userList.length}'),
                  ),
                  DataTable(
                    columnSpacing: 5,
                    columns: const <DataColumn>[
                      DataColumn(label: Text('유저 닉네임')),
                      DataColumn(label: Text('전화번호')),
                      DataColumn(label: Text('가입시기')),
                      DataColumn(label: Text('디바이스 종류')),
                    ],
                    rows: recentUserList.map((User user) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 100, // 최대 너비를 100픽셀로 제한
                              ),
                              child: buildUserDataCell(
                                  context, user.userName, user),
                            ),
                          ),
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 120, // 최대 너비를 100픽셀로 제한
                              ),
                              child: buildUserDataCell(
                                  context, user.phone, user),
                            ),
                          ),
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 80, // 최대 너비를 100픽셀로 제한
                              ),
                              child: buildUserDataCell(
                                  context,
                                  formatTemporalDateToMonthAndDay(
                                      user.createdAt.toString()),
                                  user),
                            ),
                          ),
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 80, // 최대 너비를 100픽셀로 제한
                              ),
                              child: buildUserDataCell(
                                  context, user.devicePlatform.name, user),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ));
        }),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 10), // Add left padding
          child: Text('사용자 신고 내역', style: TextStyle(fontSize: 20)),
        ),
        Consumer<ReportViewModel>(builder: (context, viewModel, child) {
          if (viewModel.reportLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          reportList = viewModel.reportItems;
          List<Report> recentReportList = reportList.take(5).toList();
          return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Text('총 사용자 신고 수: ${reportList.length}'),
                    ),
                    DataTable(
                      columnSpacing: 5,
                      columns: const <DataColumn>[
                        DataColumn(label: Text('신고종류')),
                        DataColumn(label: Text('신고이유')),
                        DataColumn(label: Text('신고작성시간')),
                        DataColumn(label: Text('신고당한 유저')),
                        DataColumn(label: Text('신고한 유저')),
                      ],
                      rows: recentReportList.map((Report reportitem) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 150, // 최대 너비를 100픽셀로 제한
                                ),
                                child: buildReportDataCell(context,
                                    reportitem.type.name, reportitem),
                              ),
                            ),
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 240, // 최대 너비를 100픽셀로 제한
                                ),
                                child: buildReportDataCell(context,
                                    reportitem.reason.name, reportitem),
                              ),
                            ),
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 100, // 최대 너비를 100픽셀로 제한
                                ),
                                child: buildReportDataCell(
                                    context,
                                    formatTemporalDateToMonthAndDay(
                                        reportitem.createdAt.toString()),
                                    reportitem),
                              ),
                            ),
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 90, // 최대 너비를 100픽셀로 제한
                                ),
                                child: buildReportDataCell(
                                    context,
                                    '${reportitem.reportedUser?.userName}',
                                    reportitem),
                              ),
                            ),
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 90, // 최대 너비를 100픽셀로 제한
                                ),
                                child: buildReportDataCell(
                                    context,
                                    '${reportitem.reporter?.userName}',
                                    reportitem),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ]));
        }),
        SizedBox(height: 100),
      ],
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

  Widget buildNoticeDataCell(
      BuildContext context, String data, PublicNotice noticeitem) {
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

  Widget buildReportDataCell(
      BuildContext context, String data, Report reportitem) {
    return SizedBox(
      width: 220,
      child: Text(data),
    );
  }
}
