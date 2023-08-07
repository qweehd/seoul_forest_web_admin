import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/user_list_edit.dart';
import 'package:seoul_forest_web_admin/user_list_write.dart'; // 이 페이지를 작성해야 합니다.
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'viewmodels/user_viewmodel.dart';
import 'models/ModelProvider.dart';

class UserItem {
  final int id;
  final int cityID;
  final DateTime createdAt;
  final String devicePlatform;
  final String deviceToken;
  final String imageKey;
  final bool isCompletelyRegistered;
  final String phone;
  final DateTime updatedAt;
  final String userName;
  final String typename;

  UserItem({
    required this.id,
    required this.cityID,
    required this.createdAt,
    required this.devicePlatform,
    required this.deviceToken,
    required this.imageKey,
    required this.isCompletelyRegistered,
    required this.phone,
    required this.updatedAt,
    required this.userName,
    required this.typename,
  });
}

class UserList extends StatefulWidget {
  const UserList({
    Key? key,
  }) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late Map<String, bool> checkedMap;
  late List<User> userList;

  @override
  void initState() {
    super.initState();
    checkedMap = {};
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, viewModel, child) {
      if (viewModel.userItems.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }
      if (viewModel.userItems != null) {
        userList = viewModel.userItems;
      }
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        child: Text('추가하기'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserWritePage()),
                          ).then((newUserItem) {
                            if (newUserItem != null) {
                              setState(() {
                                userList.add(newUserItem); // 새로운 Notice를 목록에 추가
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
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(label: Text('Select')),
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('City ID')),
                      DataColumn(label: Text('Created At')),
                      DataColumn(label: Text('Device Platform')),
                      DataColumn(label: Text('Device Token')),
                      DataColumn(label: Text('Image Key')),
                      DataColumn(label: Text('Is Completely Registered')),
                      DataColumn(label: Text('Phone')),
                      DataColumn(label: Text('Updated At')),
                      DataColumn(label: Text('User Name')),
                      DataColumn(label: Text('typename')),
                    ],
                    rows: userList.map((User useritem) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Checkbox(
                            value: checkedMap[useritem.id],
                            onChanged: (value) {
                              setState(() {
                                checkedMap[useritem.id] = value!;
                              });
                            },
                          )),
                          DataCell(buildDataCell(
                              context, '${useritem.id}', useritem)),
                          DataCell(buildDataCell(
                              context, '${useritem.city}', useritem)),
                          DataCell(buildDataCell(
                              context, '${useritem.createdAt}', useritem)),
                          DataCell(buildDataCell(
                              context, '${useritem.devicePlatform}', useritem)),
                          DataCell(buildDataCell(
                              context, useritem.deviceToken, useritem)),
                          DataCell(buildDataCell(
                              context, '${useritem.imageKey}', useritem)),
                          DataCell(buildDataCell(
                              context, '${useritem.isCompletelyRegistered}',
                              useritem)),
                          DataCell(
                              buildDataCell(context, useritem.phone, useritem)),
                          DataCell(buildDataCell(
                              context, '${useritem.updatedAt}', useritem)),
                          DataCell(buildDataCell(
                              context, useritem.userName, useritem)),
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
      userList.removeWhere((useritem) => checkedMap[useritem.id] == true);
    });
  }

  Widget buildDataCell(BuildContext context, String data, User useritem) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserListEditPage(useritem: useritem)), // 이 페이지를 작성해야 합니다.
        );
      },
      child: Text(data),
    );
  }
}
