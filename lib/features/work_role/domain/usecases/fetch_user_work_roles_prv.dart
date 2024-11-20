import 'package:dartz/dartz.dart';
import '../entities/work_private.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/work_repository.dart';

class FetchUserWorkRolesPrivate implements AsyncEitherUsecase<List<WorkRolePrv>, String> {
  final WorkRoleRepo _workRepo;

  FetchUserWorkRolesPrivate(this._workRepo);

  @override
  Future<Either<DataCRUDFailure, List<WorkRolePrv>>> call(String params) async {
    return await _workRepo.userWorkRolesPrivate(
        userId: params);
  }
}


