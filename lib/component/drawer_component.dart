import 'package:flutter/material.dart';

class AdminDrawer extends StatefulWidget {
  final Function(int) onSelected;

  const AdminDrawer({Key? key, required this.onSelected}) : super(key: key);



  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {
    return
      Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            InkWell(
              onTap: () {
                // DrawerHeader를 눌렀을 때 FirstPage로 이동하는 코드
                widget.onSelected(0);
                Navigator.of(context).pop(); // Drawer를 닫음
              },
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  '서울숲',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('대시보드'),
              onTap: () {
                widget.onSelected(0);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.announcement),
              title: const Text('공지사항'),
              onTap: () {
                widget.onSelected(1);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.padding_outlined),
              title: const Text('게시물관리'),
              onTap: () {
                widget.onSelected(2);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.supervised_user_circle),
              title: const Text('사용자관리'),
              onTap: () {
                widget.onSelected(3);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.report_problem),
              title: const Text('사용자신고관리'),
              onTap: () {
                widget.onSelected(4);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
  }
}
