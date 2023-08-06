import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seoul_forest_web_admin/post_list_edit.dart';
import 'package:seoul_forest_web_admin/post_list_write.dart';

import 'models/ModelProvider.dart';
import 'viewmodels/post_viewmodel.dart';

class PostItem {
  final int id;
  final String content;
  final DateTime createdAt;
  final String currency;
  final List<String> imageKeys;
  final bool isNegotiable;
  final int mainCategoryID;
  final String mainCategoryType;
  final double price;
  final String status;
  final int subCategoryID;
  final String title;
  final DateTime updatedAt;
  final String userID;
  final String typename;

  PostItem({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.currency,
    required this.imageKeys,
    required this.isNegotiable,
    required this.mainCategoryID,
    required this.mainCategoryType,
    required this.price,
    required this.status,
    required this.subCategoryID,
    required this.title,
    required this.updatedAt,
    required this.userID,
    required this.typename,
  });
}

class PostList extends StatefulWidget {
  const PostList({
    Key? key,
  }) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
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
      if (viewModel.postItems.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }
      if (viewModel.postItems != null) {
        postList = viewModel.postItems;
      }
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: Text('추가하기'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostListWritePage()),
                      ).then((newPostItem) {
                        if (newPostItem != null) {
                          setState(() {
                            postList.add(newPostItem);
                          });
                        }
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  // This gives some space between the buttons
                  ElevatedButton(
                    child: Text('삭제하기'),
                    onPressed: deleteSelected,
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(label: Text('Select')),
                  // 유지됨 (기능에 따라 필요할 수 있음)
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Content')),
                  DataColumn(label: Text('Price')),
                  DataColumn(label: Text('Currency')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Created At')),
                  DataColumn(label: Text('Is Negotiable')),
                  DataColumn(label: Text('Image Keys')),
                  DataColumn(label: Text('Main Category Type')),
                  DataColumn(label: Text('Sub Category ID')),
                  DataColumn(label: Text('City ID')),
                  DataColumn(label: Text('Country ID')),
                  DataColumn(label: Text('Updated At')),
                  // '__type
                ],
                rows: postList.map((Post post) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(Checkbox(
                        value: checkedMap[post.id],
                        onChanged: (value) {
                          setState(() {
                            checkedMap[post.id] = value!;
                          });
                        },
                      )),
                      DataCell(buildDataCell(context, '${post.id}', post)),
                      DataCell(buildDataCell(context, post.content, post)),
                      DataCell(
                          buildDataCell(context, '${post.createdAt}', post)),
                      DataCell(buildDataCell(context, post.currency!, post)),
                      DataCell(
                          buildDataCell(context, '${post.imageKeys}', post)),
                      DataCell(
                          buildDataCell(context, '${post.isNegotiable}', post)),
                      DataCell(buildDataCell(
                          context, post.mainCategoryType.toString(), post)),
                      DataCell(buildDataCell(context, '${post.price}', post)),
                      DataCell(buildDataCell(
                          context, '${post.subCategory?.id}', post)),
                      DataCell(buildDataCell(context, post.title, post)),
                      DataCell(
                          buildDataCell(context, '${post.updatedAt}', post)),
                      DataCell(
                          buildDataCell(context, post.authorUser!.id, post)),
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

  void deleteSelected() {
    setState(() {
      postList.removeWhere((postitem) => checkedMap[postitem.id] == true);
    });
  }

  Widget buildDataCell(BuildContext context, String data, Post postitem) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostListEditPage(postitem: postitem)),
        );
      },
      child: Text(data),
    );
  }
}
