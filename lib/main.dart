import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:seoul_forest_web_admin/component/drawer_component.dart';
import 'package:seoul_forest_web_admin/data/post_repository.dart';
import 'package:seoul_forest_web_admin/first_page.dart';
import 'package:seoul_forest_web_admin/post_list.dart';
import 'package:seoul_forest_web_admin/public_notice.dart';
import 'package:seoul_forest_web_admin/public_notice/create_pn_modal_component.dart';
import 'package:seoul_forest_web_admin/report_list.dart';
import 'package:seoul_forest_web_admin/user_list.dart';
import 'package:seoul_forest_web_admin/viewmodels/public_notice_viewmodel.dart';
import 'package:seoul_forest_web_admin/viewmodels/post_viewmodel.dart';
import 'package:seoul_forest_web_admin/viewmodels/report_viewmodel.dart';
import 'package:seoul_forest_web_admin/viewmodels/user_viewmodel.dart';
import 'amplifyconfiguration.dart';
import 'data/public_notice_repository.dart';
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
          create: (context) => PublicNoticeViewModel(
              publicNoticeRepository: PublicNoticeRepository())),
      ChangeNotifierProvider(
          create: (context) => UserViewModel(userRepository: UserRepository())),
      ChangeNotifierProvider(
          create: (context) =>
              ReportViewModel(reportRepository: ReportRepository())),
    ],
    child: const MyApp(),
  ));
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(),
    ),
    GoRoute(
      path: '/public_notice',
      builder: (context, state) => const PublicNoticeList(),
    ),
    GoRoute(
        path: '/public_notice/create',
        builder: (context, state) => const CreatePublicNoticeModal()),
    GoRoute(
      path: '/post',
      builder: (context, state) => const PostList(),
    ),
    GoRoute(
      path: '/user',
      builder: (context, state) => const UserList(),
    ),
    GoRoute(
      path: '/report',
      builder: (context, state) => const ReportList(),
    ),
  ],
);

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
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'Responsive Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
