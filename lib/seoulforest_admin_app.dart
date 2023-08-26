import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seoul_forest_web_admin/post_list.dart';
import 'package:seoul_forest_web_admin/public_notice.dart';
import 'package:seoul_forest_web_admin/public_notice/create_pn_modal_component.dart';
import 'package:seoul_forest_web_admin/report_list.dart';
import 'package:seoul_forest_web_admin/user_list.dart';

import 'base_screen.dart';

class SeoulForestAdminApp extends StatefulWidget {
  const SeoulForestAdminApp({super.key});

  @override
  State<SeoulForestAdminApp> createState() => _SeoulForestAdminAppState();
}

class _SeoulForestAdminAppState extends State<SeoulForestAdminApp> {
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const BaseScreen(),
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
