


import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:floward_task/Feature/data/datasources/post/post_local_datasource.dart';
import 'package:floward_task/Feature/data/datasources/post/post_remote_datasource.dart';
import 'package:floward_task/Feature/data/datasources/user/user_local_datasource.dart';
import 'package:floward_task/Feature/data/datasources/user/user_remote_datasource.dart';
import 'package:floward_task/Feature/data/repositories/post_repository_impl.dart';
import 'package:floward_task/Feature/data/repositories/user_repository_impl.dart';
import 'package:floward_task/Feature/domain/repositories/PostRepository.dart';
import 'package:floward_task/Feature/domain/repositories/UserRepository.dart';
import 'package:floward_task/Feature/domain/usecases/get_user_posts.dart';
import 'package:floward_task/core/network/network_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkInfoProvider = Provider<NetworkInfo>((_) => NetworkInfoImpl(DataConnectionChecker()));


final Provider<UserLocalDataSource> userLocalDataSourceProvider = Provider<UserLocalDataSource>((_) => UserLocalDataSourceImpl());
final Provider<UserRemoteDataSource> userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((_) => UserRemoteDataSourceImpl());

final Provider<UserRepository> userRepositoryProvider =
Provider<UserRepository>((ref) => UserRepositoryImpl(remoteDataSource: ref.watch(userRemoteDataSourceProvider),localDataSource: ref.watch(userLocalDataSourceProvider),networkInfo: ref.watch(networkInfoProvider)));


final Provider<PostLocalDataSource> postLocalDataSourceProvider = Provider<PostLocalDataSource>((_) => PostLocalDataSourceImpl());
final Provider<PostRemoteDataSource> postRemoteDataSourceProvider = Provider<PostRemoteDataSource>((_) => PostRemoteDataSourceImpl());

final Provider<PostRepository> postRepositoryProvider =
Provider<PostRepository>((ref) => PostRepositoryImpl(remoteDataSource: ref.watch(postRemoteDataSourceProvider),localDataSource: ref.watch(postLocalDataSourceProvider),networkInfo: ref.watch(networkInfoProvider)));



final Provider<Params> paramsProvider = Provider<Params>((_) => Params());