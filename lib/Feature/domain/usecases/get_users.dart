import 'package:dartz/dartz.dart';
import 'package:floward_task/Feature/domain/entities/user.dart';
import 'package:floward_task/Feature/domain/repositories/UserRepository.dart';
import 'package:floward_task/core/error/failure.dart';
import 'package:floward_task/core/usecases/usecase.dart';

class GetUsers implements UseCase<List<User>,NoParams>
{
  final UserRepository repository;

  GetUsers(this.repository);

  // callable classes
  @override
  Future<Either<Failure, List<User>>> call(NoParams noParams) async {
    return await repository.getUsers();
  }
}