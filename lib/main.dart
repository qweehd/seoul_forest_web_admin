import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/post_list.dart';
import 'package:seoul_forest_web_admin/report_list.dart';
import 'package:seoul_forest_web_admin/report_list_item.dart';
import 'package:seoul_forest_web_admin/user_list.dart';
import 'package:seoul_forest_web_admin/user_list_item.dart';
import 'public_notice.dart';
import 'package:seoul_forest_web_admin/post_list_item.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final _pages = [const PublicNotice(), PostList(postItems: getPostItems()), UserList(userItems: getUserItems()), ReportList(reportItems: getReportItems(),)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('관리자페이지'),
        actions: <Widget>[
          TextButton(
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back, color: Colors.white),
                Text('돌아가기', style: TextStyle(color: Colors.white)),
              ],
            ),
            onPressed: () {
              if (_currentIndex != 0) {
                setState(() {
                  _currentIndex = 0;
                });
              } else {
                Navigator.of(context).maybePop();
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              child: Text(
                '서울숲',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.announcement),
              title: const Text('공지사항'),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.manage_accounts),
              title: const Text('게시물관리'),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.supervised_user_circle),
              title: const Text('사용자관리'),
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.report_problem),
              title: const Text('사용자신고관리'),
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
    );
  }
}
