import 'package:dartz/dartz.dart';
import '../entities/work_public.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/work_repository.dart';

class FetchUserWorkRoles implements AsyncEitherUsecase<List<WorkRolePub>, String> {
  final WorkRoleRepo _workRepo;

  FetchUserWorkRoles(this._workRepo);

  @override
  Future<Either<DataCRUDFailure, List<WorkRolePub>>> call(String userId) async {
    return await _workRepo.userWorkRoles(
        userId: userId);
  }
}


