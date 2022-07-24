import 'dart:ffi';

import 'package:floward_task/Feature/domain/entities/post.dart';
import 'package:floward_task/Feature/domain/usecases/get_user_posts.dart';
import 'package:floward_task/Feature/presentation/view/posts/post_item.dart';
import 'package:floward_task/Feature/presentation/viewmodel/user_post_count_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostList extends StatelessWidget
{

  final int userId;
  final String thumbnailUrl;
  PostList(this.userId, this.thumbnailUrl);

  final _userPostProvider = userPostListVieModelStateNotifierProvider;

  Widget _buildPostListContainerWidget(final BuildContext context, final List<Post> PostList) {
    return _buildPostListWidget(context, PostList);
  }

  Widget _buildPostListWidget(final BuildContext context, final List<Post> PostList) {
    if (PostList.length == 0) {
      return const Center(child: Text('No Post'));
    } else {
      return Scaffold(
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(thumbnailUrl),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: PostList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PostItem(PostList.elementAt(index));
                  }
              ),
            ),
          ],),
      );
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