import 'package:dartz/dartz.dart';
import '../entities/work_private.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/work_repository.dart';

class ApproveWorkRoleComplete implements AsyncEitherUsecase<Success, WorkRolePrv> {
  final WorkRoleRepo _workRepo;

  ApproveWorkRoleComplete(this._workRepo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(WorkRolePrv params) async {
    return await _workRepo.approveWorkRole(workRolePrv: params);
  }
}
