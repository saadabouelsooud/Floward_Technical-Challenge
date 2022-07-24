import 'package:floward_task/Feature/domain/domain_module.dart';
import 'package:floward_task/Feature/domain/entities/post.dart';
import 'package:floward_task/Feature/domain/usecases/get_posts.dart';
import 'package:floward_task/Feature/presentation/state/state.dart';
import 'package:floward_task/Feature/presentation/viewmodel/user_post_count_viewmodel.dart';
import 'package:floward_task/core/error/exceptions.dart';
import 'package:floward_task/core/usecases/usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postListVieModelStateNotifierProvider =
StateNotifierProvider.autoDispose<PostListViewModel, State<List<Post>>>((ref) {
  return PostListViewModel(
    ref.watch(getPostsProvider),
  );
});

class PostListViewModel extends StateNotifier<State<List<Post>>>
{
  final GetPosts _getPosts;

  PostListViewModel(
      this._getPosts,
      ) : super(const State.init()) {
    _getPostList();
  }

  _getPostList() async {
    state = const State.loading();
    final postList = await _getPosts(NoParams());
    postList.fold(
            (failure) => state = State.error(mapFailureToException(failure)),
            (list) => state = State.success(list)
    );
  }
}