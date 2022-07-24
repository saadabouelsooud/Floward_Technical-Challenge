

import 'package:floward_task/Feature/data/data_module.dart';
import 'package:floward_task/Feature/domain/usecases/get_posts.dart';
import 'package:floward_task/Feature/domain/usecases/get_user_posts.dart';
import 'package:floward_task/Feature/domain/usecases/get_users.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getUsersProvider =
Provider<GetUsers>((ref) => GetUsers(ref.watch(userRepositoryProvider)));

final getPostsProvider =
Provider<GetPosts>((ref) => GetPosts(ref.watch(postRepositoryProvider)));

final getUserPostsProvider =
Provider<GetUserPosts>((ref) => GetUserPosts(ref.watch(postRepositoryProvider)));