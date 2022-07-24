import 'package:dartz/dartz.dart';
import 'package:floward_task/Feature/domain/entities/post.dart';
import 'package:floward_task/Feature/domain/repositories/PostRepository.dart';
import 'package:floward_task/core/error/failure.dart';
import 'package:floward_task/core/usecases/usecase.dart';

class GetPosts implements UseCase<List<Post>,NoParams>
{
  final PostRepository repository;

  GetPosts(this.repository);

  // callable classes
  @override
  Future<Either<Failure, List<Post>>> call(NoParams noParams) async {
    return await repository.getPosts();
  }
}