import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seoul_forest_web_admin/data/post_repository.dart';
import 'package:seoul_forest_web_admin/post_list.dart';
import 'package:seoul_forest_web_admin/public_notice.dart';
import 'package:seoul_forest_web_admin/report_list.dart';
import 'package:seoul_forest_web_admin/user_list.dart';
import 'package:seoul_forest_web_admin/viewmodels/notice_viewmodel.dart';
import 'package:seoul_forest_web_admin/viewmodels/post_viewmodel.dart';
import 'package:seoul_forest_web_admin/viewmodels/report_viewmodel.dart';
import 'package:seoul_forest_web_admin/viewmodels/user_viewmodel.dart';
import 'amplifyconfiguration.dart';
import 'data/notice_repository.dart';
import 'data/report_repository.dart';
import 'data/user_repository.dart';
import 'models/ModelProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => PostViewModel(postRepository: PostRepository())),
      ChangeNotifierProvider(
          create: (context) =>
              NoticeViewModel(noticeRepository: NoticeRepository())),
      ChangeNotifierProvider(
          create: (context) => UserViewModel(userRepository: UserRepository())),
      ChangeNotifierProvider(
          create: (context) =>
              ReportViewModel(reportRepository: ReportRepository())),
    ],
    child: const MyApp(),
  ));
}

Future<void> configureAmplify() async {
  try {
    await Amplify.addPlugins([
      AmplifyAPI(modelProvider: ModelProvider.instance),
      // AmplifyStorageS3(),
    ]);
    await Amplify.configure(amplifyconfig);
    safePrint('Amplify 설정 완료');
  } on Exception catch (e) {
    safePrint(e.toString());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  final _pages = [
    const PostList(),
    const PublicNoticeList(),
    const UserList(),
    const ReportList()
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<PostViewModel>(context, listen: false).queryPostItems();
    Provider.of<NoticeViewModel>(context, listen: false).queryNoticeItems();
    Provider.of<UserViewModel>(context, listen: false).queryUserItems();
    Provider.of<ReportViewModel>(context, listen: false).queryReportItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('서울숲 관리자 페이지'),
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
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.announcement),
              title: const Text('공지사항'),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.manage_accounts),
              title: const Text('게시물관리'),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
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
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _pages[_currentIndex],
      ),
    );
  }
}
