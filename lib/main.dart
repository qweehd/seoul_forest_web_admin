import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seoul_forest_web_admin/data/post_repository.dart';
import 'package:seoul_forest_web_admin/data/region_repository.dart';
import 'package:seoul_forest_web_admin/seoulforest_admin_app.dart';
import 'package:seoul_forest_web_admin/viewmodels/public_notice_viewmodel.dart';
import 'package:seoul_forest_web_admin/viewmodels/post_viewmodel.dart';
import 'package:seoul_forest_web_admin/viewmodels/region_viewmodel.dart';
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
          create: (context) =>
              RegionViewModel(regionRepository: RegionRepository())),
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
    child: const SeoulForestAdminApp(),
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
