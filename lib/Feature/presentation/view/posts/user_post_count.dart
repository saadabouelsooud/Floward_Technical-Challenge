
import 'package:floward_task/Feature/domain/entities/post.dart';
import 'package:floward_task/Feature/presentation/viewmodel/user_post_count_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:floward_task/Feature/domain/usecases/get_user_posts.dart';

class UserPostCount extends StatelessWidget
{
  final int userId;
  UserPostCount(this.userId);

  final _userPostProvider = userPostListVieModelStateNotifierProvider;


  Widget _buildPostListContainerWidget(final BuildContext context, final List<Post> postList) {
    return _buildPostListWidget(context, postList);
  }

  Widget _buildPostListWidget(final BuildContext context, final List<Post> postList) {
    if (postList.length == 0) {
      return const Center(child: Text('No Post'));
    } else {
      var userPostCount = postList.length.toString();
      return SafeArea(child: Text(userPostCount));
    }
  }
  Widget _buildErrorWidget() {
    return const Center(child: Text('An error has occurred!'));
  }


  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, watch, _) {
          return watch(_userPostProvider(Params(userId: userId))).maybeWhen(
            success: (content) => _buildPostListContainerWidget(context, content),
            error: (_) => _buildErrorWidget(),
            orElse: () => Center(child: CircularProgressIndicator()),
          );
        }
    );
  }

}