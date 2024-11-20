import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/work_private.dart';
import '../repositories/work_repository.dart';

class SaveWorkRole implements AsyncEitherUsecase<Success, WorkRolePrv> {
  final WorkRoleRepo _teacherRepo;

  SaveWorkRole(this._teacherRepo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(WorkRolePrv params) async {
    return await _teacherRepo.saveWorkRole(workRolePrv: params);
  }
}
