import 'package:dartz/dartz.dart';
import 'package:floward_task/Feature/data/datasources/post/post_local_datasource.dart';
import 'package:floward_task/Feature/data/datasources/post/post_remote_datasource.dart';
import 'package:floward_task/Feature/domain/entities/post.dart';
import 'package:floward_task/Feature/domain/repositories/PostRepository.dart';
import 'package:floward_task/core/error/exceptions.dart';
import 'package:floward_task/core/error/failure.dart';
import 'package:floward_task/core/network/network_info.dart';

class PostRepositoryImpl implements PostRepository {

  final PostRemoteDataSource? remoteDataSource;
  final PostLocalDataSource? localDataSource;
  final NetworkInfo? networkInfo;

  PostRepositoryImpl(
      {this.remoteDataSource, this.localDataSource, this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    if (await networkInfo!.isConnected) {
      try {
        final posts = await remoteDataSource!.getPosts();
        localDataSource!.cachePosts(posts);
        return Right(posts);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    else {
      try {
        final posts = await localDataSource!.getCachePosts();
        return Right(posts);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }


  @override
  Future<Either<Failure, List<Post>>> getUserPosts(int userId) async {
    try {
      final posts = await remoteDataSource!.getUserPosts(userId);
      localDataSource!.cachePosts(posts);
      return Right(posts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}