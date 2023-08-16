import 'package:flutter/material.dart';
import 'package:seoul_forest_web_admin/user_list_edit.dart';
import 'package:seoul_forest_web_admin/user_list_write.dart'; // 이 페이지를 작성해야 합니다.
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'viewmodels/user_viewmodel.dart';
import 'models/ModelProvider.dart';

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
      if (viewModel.userLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      userList = viewModel.userItems;
      return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
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
                    rows: userList.map((User user) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Checkbox(
                            value: checkedMap[user.id] ?? false,
                            onChanged: (value) {
                              setState(() {
                                checkedMap[user.id] = value!;
                              });
                            },
                          )),

                          DataCell(buildDataCell(
                              context, '${user.id}', user)),
                          DataCell(buildDataCell(
                              context, '${user.city}', user)),

                          DataCell(buildDataCell(
                              context, '${user.createdAt}', user)),
                          DataCell(buildDataCell(
                              context, '${user.devicePlatform}', user)),
                          DataCell(buildDataCell(
                              context, user.deviceToken, user)),

                          DataCell(buildDataCell(
                              context, '${user.imageKey}', user)),
                          DataCell(buildDataCell(
                              context, '${user.isCompletelyRegistered}',
                              user)),
                          DataCell(
                              buildDataCell(context, user.phone, user)),

                          DataCell(buildDataCell(
                              context, '${user.updatedAt}', user)),
                          DataCell(buildDataCell(
                              context, user.userName, user)),
                          DataCell(buildDataCell(
                              context, 'User', user)),
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
      Provider.of<UserViewModel>(
          context,
          listen: false)
          .deleteUserByID(checkedMap);
    });
  }

  Widget buildDataCell(BuildContext context, String data, User useritem) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserListEditPage(useritem: useritem)), // 이 페이지를 작성해야 합니다.
        );
      },
      child: SizedBox(
        width: 220,
        child: Text(data),
      ),
    );
  }
}
