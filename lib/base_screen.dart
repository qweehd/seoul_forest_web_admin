import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seoul_forest_web_admin/post_list.dart';
import 'package:seoul_forest_web_admin/public_notice.dart';
import 'package:seoul_forest_web_admin/report_list.dart';
import 'package:seoul_forest_web_admin/user_list.dart';
import 'package:seoul_forest_web_admin/viewmodels/post_viewmodel.dart';
import 'package:seoul_forest_web_admin/viewmodels/public_notice_viewmodel.dart';
import 'package:seoul_forest_web_admin/viewmodels/region_viewmodel.dart';
import 'package:seoul_forest_web_admin/viewmodels/report_viewmodel.dart';
import 'package:seoul_forest_web_admin/viewmodels/user_viewmodel.dart';

import 'component/drawer_component.dart';
import 'view/dashboard/dashboard_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _currentIndex = 0;
  final _pages = [
    const DashBoard(),
    const PublicNoticeList(),
    const PostList(),
    const UserList(),
    const ReportList()
  ];

  final Map<int, String> _titles = {
    0: '대시보드',
    1: '공지사항 관리',
    2: '게시글 관리',
    3: '유저 관리',
    4: '신고 관리'
  };

  @override
  void initState() {
    super.initState();
    Provider.of<RegionViewModel>(context, listen: false).queryCountryItems();
    Provider.of<PostViewModel>(context, listen: false).queryPostItems();
    Provider.of<PublicNoticeViewModel>(context, listen: false)
        .queryNoticeItems();
    Provider.of<UserViewModel>(context, listen: false).queryUserItems();
    Provider.of<ReportViewModel>(context, listen: false).queryReportItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]!),
      ),
      drawer: AdminDrawer(
        onSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: SingleChildScrollView(child: _pages[_currentIndex]),
    );
  }
}
