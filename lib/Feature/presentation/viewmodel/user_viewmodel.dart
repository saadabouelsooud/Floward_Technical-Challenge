import 'package:floward_task/Feature/domain/domain_module.dart';
import 'package:floward_task/Feature/domain/entities/user.dart';
import 'package:floward_task/Feature/domain/usecases/get_users.dart';
import 'package:floward_task/Feature/presentation/state/state.dart';
import 'package:floward_task/core/error/exceptions.dart';
import 'package:floward_task/core/usecases/usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userListVieModelStateNotifierProvider =
StateNotifierProvider.autoDispose<UserListViewModel, State<List<User>>>((ref) {
  return UserListViewModel(
    ref.watch(getUsersProvider),
  );
});

class UserListViewModel extends StateNotifier<State<List<User>>>
{
  final GetUsers _getUsers;

  UserListViewModel(
      this._getUsers,
      ) : super(const State.init()) {
    _getUserList();
  }

  _getUserList() async {
    state = const State.loading();
    final userList = await _getUsers(NoParams());
    userList.fold(
            (failure) => state = State.error(mapFailureToException(failure)),
            (list) => state = State.success(list)
    );
  }

  User getUserByUserId(int userId)
  {
    return state.data!.where((element) => element.userId == userId).first;
  }

}