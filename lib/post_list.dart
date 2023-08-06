import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:seoul_forest_web_admin/post_list_edit.dart';
import 'package:seoul_forest_web_admin/post_list_write.dart';

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
  final List<PostItem> postItems;

  const PostList({Key? key, required this.postItems}) : super(key: key);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  late Map<int, bool> checkedMap;
  late List<PostItem> postitems;

  @override
  void initState() {
    super.initState();
    checkedMap = {for (var i = 0; i < 10; i++) i: false};
    postitems = widget.postItems;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostViewModel>(
      builder: (context, viewModel, child) {
        safePrint('viewModel.postItems.length: ${viewModel.postItems.length}');
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
                          MaterialPageRoute(builder: (context) => PostListWritePage()),
                        ).then((newPostItem) {
                          if (newPostItem != null) {
                            setState(() {
                              postitems.add(newPostItem);
                            });
                          }
                        });
                      },
                    ),
                    SizedBox(width: 10), // This gives some space between the buttons
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
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Content')),
                    DataColumn(label: Text('Created At')),
                    DataColumn(label: Text('Currency')),
                    DataColumn(label: Text('Image Keys')),
                    DataColumn(label: Text('Is Negotiable')),
                    DataColumn(label: Text('Main Category ID')),
                    DataColumn(label: Text('Main Category Type')),
                    DataColumn(label: Text('Price')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Sub Category ID')),
                    DataColumn(label: Text('Title')),
                    DataColumn(label: Text('Updated At')),
                    DataColumn(label: Text('User ID')),
                    DataColumn(label: Text('__typename')),
                  ],
                  rows: postitems.map((PostItem postitem) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Checkbox(
                          value: checkedMap[postitem.id],
                          onChanged: (value) {
                            setState(() {
                              checkedMap[postitem.id] = value!;
                            });
                          },
                        )),
                        DataCell(buildDataCell(context, '${postitem.id}', postitem)),
                        DataCell(buildDataCell(context, postitem.content, postitem)),
                        DataCell(buildDataCell(context, '${postitem.createdAt}', postitem)),
                        DataCell(buildDataCell(context, postitem.currency, postitem)),
                        DataCell(buildDataCell(context, '${postitem.imageKeys}', postitem)),
                        DataCell(buildDataCell(context, '${postitem.isNegotiable}', postitem)),
                        DataCell(buildDataCell(context, '${postitem.mainCategoryID}', postitem)),
                        DataCell(buildDataCell(context, postitem.mainCategoryType, postitem)),
                        DataCell(buildDataCell(context, '${postitem.price}', postitem)),
                        DataCell(buildDataCell(context, postitem.status, postitem)),
                        DataCell(buildDataCell(context, '${postitem.subCategoryID}', postitem)),
                        DataCell(buildDataCell(context, postitem.title, postitem)),
                        DataCell(buildDataCell(context, '${postitem.updatedAt}', postitem)),
                        DataCell(buildDataCell(context, postitem.userID, postitem)),
                        DataCell(buildDataCell(context, postitem.typename, postitem)),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  void deleteSelected() {
    setState(() {
      postitems.removeWhere((postitem) => checkedMap[postitem.id] == true);
    });
  }

  Widget buildDataCell(BuildContext context, String data, PostItem postitem) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostListEditPage(postitem: postitem)),
        );
      },
      child: Text(data),
    );
  }
}
