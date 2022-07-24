import 'package:floward_task/Feature/domain/entities/user.dart';
import 'package:floward_task/Feature/presentation/view/posts/user_posts.dart';
import 'package:floward_task/Feature/presentation/view/users/user_item.dart';
import 'package:floward_task/Feature/presentation/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserList extends StatelessWidget
{
  final _userProvider = userListVieModelStateNotifierProvider;

  Widget _buildUserListContainerWidget(final BuildContext context, final List<User> UserList) {
    return _buildUserListWidget(context, UserList);
  }

  Widget _buildUserListWidget(final BuildContext context, final List<User> userList) {
    if (userList.length == 0) {
      return const Center(child: Text('No User'));
    } else {
      return SafeArea(child: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (BuildContext context, int index) {
            var currentUser = userList.elementAt(index);
            return InkWell(
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PostList(currentUser.userId!,currentUser.thumbnailUrl!)),
                );
              },
                child: UserItem(currentUser));
          }
      ));
    }
  }
  Widget _buildErrorWidget() {
    return const Center(child: Text('An error has occurred!'));
  }


  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, watch, _) {
          return watch(_userProvider).maybeWhen(
            success: (content) => _buildUserListContainerWidget(context, content),
            error: (_) => _buildErrorWidget(),
            orElse: () => Center(child: CircularProgressIndicator()),
          );
        }
    );
  }

}