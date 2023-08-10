import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seoul_forest_web_admin/post_list.dart';
import 'package:seoul_forest_web_admin/post_list_edit.dart';
import 'package:seoul_forest_web_admin/post_list_write.dart';

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

  @override
  void initState() {
    super.initState();
    checkedMap = {};
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostViewModel>(builder: (context, viewModel, child) {
      if (viewModel.postLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      postList = viewModel.postItems;
      postList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Content')),
                  DataColumn(label: Text('Created At')),
                  DataColumn(label: Text('Main Category Type')),
                  DataColumn(label: Text('Sub Category ID')),
                ],
                rows: postList.map((Post post) {
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
                          context, post.mainCategoryType.toString(), post)),
                      /* SubCategoryID Field*/
                      DataCell(buildDataCell(
                          context, '${post.subCategory?.id}', post)),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildDataCell(BuildContext context, String data, Post postitem) {
    return SizedBox(
      width: 220,
      child: Text(data),
    );
  }
}
