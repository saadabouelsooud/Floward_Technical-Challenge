import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:floward_task/Feature/domain/entities/post.dart';
import 'package:floward_task/Feature/domain/repositories/PostRepository.dart';
import 'package:floward_task/core/error/failure.dart';
import 'package:floward_task/core/usecases/usecase.dart';

class GetUserPosts implements UseCase<List<Post>,Params>{
  final PostRepository repository;

  GetUserPosts(this.repository);


  // callable classes
  Future<Either<Failure, List<Post>>> call(Params params) async
  {
    return await repository.getUserPosts(params.userId!);
  }
}

class Params extends Equatable
{
  final int? userId;

  Params({this.userId});

  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}