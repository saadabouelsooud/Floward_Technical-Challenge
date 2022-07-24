import 'package:dartz/dartz.dart';
import 'package:floward_task/Feature/domain/entities/user.dart';
import 'package:floward_task/core/error/failure.dart';

abstract class UserRepository
{
  Future<Either<Failure,List<User>>> getUsers();
}