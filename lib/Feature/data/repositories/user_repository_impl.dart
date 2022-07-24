import 'package:dartz/dartz.dart';
import 'package:floward_task/Feature/data/datasources/user/user_local_datasource.dart';
import 'package:floward_task/Feature/data/datasources/user/user_remote_datasource.dart';
import 'package:floward_task/Feature/domain/entities/user.dart';
import 'package:floward_task/Feature/domain/repositories/UserRepository.dart';
import 'package:floward_task/core/error/exceptions.dart';
import 'package:floward_task/core/error/failure.dart';
import 'package:floward_task/core/network/network_info.dart';

class UserRepositoryImpl implements UserRepository
{

  final UserRemoteDataSource? remoteDataSource;
  final UserLocalDataSource? localDataSource;
  final NetworkInfo? networkInfo;

  UserRepositoryImpl({this.remoteDataSource,this.localDataSource,this.networkInfo});

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    if (await networkInfo!.isConnected)
    {
    try {
      final users = await remoteDataSource!.getUsers();
      localDataSource!.cacheUsers(users);
      return Right(users);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
    else
      {
        try{
          final users = await localDataSource!.getCacheUsers();
          return Right(users);
        } on CacheException{return Left(CacheFailure());}
      }

  }

}