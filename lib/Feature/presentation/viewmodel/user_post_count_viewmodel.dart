import 'package:floward_task/Feature/domain/domain_module.dart';
import 'package:floward_task/Feature/domain/entities/post.dart';
import 'package:floward_task/Feature/domain/usecases/get_posts.dart';
import 'package:floward_task/Feature/domain/usecases/get_user_posts.dart';
import 'package:floward_task/Feature/presentation/state/state.dart';
import 'package:floward_task/core/error/exceptions.dart';
import 'package:floward_task/core/usecases/usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userPostListVieModelStateNotifierProvider =
StateNotifierProvider.autoDispose.family<UserPostListViewModel,State<List<Post>>, Params>((ref, params) {
  print(params.userId);
  return UserPostListViewModel(ref.watch(getUserPostsProvider),params.userId!);
  // Do something with userId/locale
});


class UserPostListViewModel extends StateNotifier<State<List<Post>>>
{
  final GetUserPosts _getUserPosts;
  final int userId;
  UserPostListViewModel(
      this._getUserPosts, this.userId,
      ) : super(const State.init()) {
    _getUserPostList();
  }

  _getUserPostList() async {
    state = const State.loading();
    final postList = await _getUserPosts(Params(userId: userId));
    postList.fold(
            (failure) => state = State.error(mapFailureToException(failure)),
            (list) => state = State.success(list)
    );
  }

}