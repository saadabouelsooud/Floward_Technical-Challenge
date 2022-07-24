import 'package:dartz/dartz.dart';
import 'package:floward_task/Feature/domain/entities/post.dart';
import 'package:floward_task/core/error/failure.dart';

abstract class PostRepository
{
  Future<Either<Failure,List<Post>>> getPosts();
  Future<Either<Failure,List<Post>>> getUserPosts(int userId);
}